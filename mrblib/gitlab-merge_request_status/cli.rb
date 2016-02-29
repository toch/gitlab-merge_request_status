module GitlabMergeRequestStatus
  class CLI
    def initialize(argv, output_io = $stdout, error_io = $stderr)
      @options = setup_options
      @opts = @options.parse(argv)
      @output_io = output_io
      @error_io  = error_io
    end

    def run
      if @options.option(:version)
        Version.new(@output_io).run
      elsif @options.option(:help)
        Help.new(@output_io).run
      else
        host = @options.option(:host)
        api = API.new(
          @options.option(:token),
          host
        )

        project = @options.option(:project)
        branch = @options.option(:branch)

        begin
          project_id = api.get_project_id(project)
        rescue RuntimeError => e
          exit_on_error "Project #{project} not found or accessible"
        end

        begin
          merge_request = api.get_merge_request(project_id, branch)
        rescue RuntimeError => e
          exit_on_error "Branch #{project}/#{branch} not found or accessible"
        end

        @output_io.puts "https://#{host}/#{project}/merge_requests/#{merge_request["iid"]}"
      end
    end

    private
    def setup_options
      options = Options.new
      options.add(Option.new("host", "H", true))
      options.add(Option.new("token", "t", true))
      options.add(Option.new("project", "p", true))
      options.add(Option.new("branch", "b", true))
      options.add(Option.new("version", "v"))
      options.add(Option.new("help", "h"))

      options
    end

    def exit_on_error(message, code = 1)
      @error_io.puts message
      exit code
    end
  end
end
