require 'github_badges'
require 'spec'
require 'rack/test'
require 'mocha'

set :environment, :test

module RackSpecHelper
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
end

Spec::Runner.configure do |conf|
  conf.include RackSpecHelper
end