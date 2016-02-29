module GitlabMergeRequestStatus
  class API
    def initialize(token, host)
      @token = token
      @host = host
      @http_request = HttpRequest.new()
    end

    def get_project_id(project)
      responses = get url({ "projects" => nil }, { "per_page" => 100 })
      found = responses.select{ |response| response["path_with_namespace"] == project }.first
      raise RuntimeError.new("#{project} is not found or not accessible.") unless found
      found["id"]
    end

    def get_merge_request(project_id, branch)
      responses = get url(
        {
          "projects" => project_id,
          "merge_requests" => nil
        },
        {
          "state" => "opened"
        }
      )
      found = responses.select{ |response| response["source_branch"] == branch }.first
      raise RuntimeError.new("#{branch} is not linked to any open merge request.") unless found
      found
    end

    private
    def url(resources, params = nil)
      str = "https://#{@host}/api/v3/#{to_path(resources)}#{to_query(params)}"
      str
    end

    def to_query(params)
      str = ""
      if params && !params.empty?
        str << "?"
        str << params.map do |param, value|
          param_str = "#{param}"
          param_str << "=#{@http_request.escape(value)}" unless value.nil?
          param_str
        end.join("&")
      end
      str
    end

    def to_path(resources)
      str = ""
      resources.each do |resource, id|
        str << "/#{resource}"
        str << "/#{id}" if id
      end
      str
    end

    def get(url)
      JSON::parse @http_request.get(
        url,
        nil,
        {
          "Accept" => "application/json",
          "PRIVATE-TOKEN" => @token
        }
      ).body
    end

  end
end

