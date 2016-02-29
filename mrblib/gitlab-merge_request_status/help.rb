module GitlabMergeRequestStatus
  class Help
    def initialize(output_io)
      @output_io = output_io
    end

    def run
      @output_io.puts "gitlab-merge_request_status [switches] [arguments]"
      @output_io.puts "gitlab-merge_request_status -t, --token              : private token (required)"
      @output_io.puts "gitlab-merge_request_status -H, --host               : GitLab server host  (required)"
      @output_io.puts "gitlab-merge_request_status -p, --project            : project  (required)"
      @output_io.puts "gitlab-merge_request_status -b, --branch             : current branch  (required)"
      @output_io.puts "gitlab-merge_request_status -h, --help               : show this message"
      @output_io.puts "gitlab-merge_request_status -v, --version            : print gitlab-merge_request_status version"
    end
  end
end
