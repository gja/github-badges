require 'github_badges'
require 'spec'
require 'rack/test'
require 'mocha'
require 'rspec_tag_matchers'

set :environment, :test

module RackSpecHelper
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

Spec::Runner.configure do |conf|
  conf.include RackSpecHelper, RspecTagMatchers
end
