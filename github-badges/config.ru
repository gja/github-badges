$:.unshift File.dirname(__FILE__) + "/lib/"
require 'github_badges'
run Sinatra::Application
