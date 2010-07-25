$:.unshift File.dirname(__FILE__) + "/lib/"
require 'github_badges'
use Rack::Static, :urls => ["/images"], :root => "public"
run Sinatra::Application
