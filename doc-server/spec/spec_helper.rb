require 'rubygems'
require 'bundler'
Bundler.require(:test)

require 'sinatra'
require 'rack/test'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

require File.join(File.dirname(__FILE__), '..', 'docs')