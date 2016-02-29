require_relative 'mrblib/gitlab-merge_request_status/version'

spec = MRuby::Gem::Specification.new('gitlab-merge_request_status') do |spec|
  spec.bins    = ['gitlab-merge_request_status']

  spec.add_dependency 'mruby-exit', :core => 'mruby-exit'
  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-time', :core => 'mruby-time'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-getopts', :mgem => 'mruby-getopts'
  spec.add_dependency 'mruby-polarssl', :github => 'toch/mruby-polarssl'
  spec.add_dependency 'mruby-httprequest', :mgem => 'mruby-httprequest'
  spec.add_dependency 'mruby-base64', :mgem => 'mruby-base64'
  spec.add_dependency 'mruby-json', :github => 'mattn/mruby-json'
end

spec.license = 'MIT'
spec.author  = 'Christophe Philemotte'
spec.summary = 'gitlab-merge_request_status'
spec.version = GitlabMergeRequestStatus::Version::VERSION
