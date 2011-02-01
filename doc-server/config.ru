require 'rubygems'
require 'bundler'

Bundler.require

# Sinatra::Application.default_options.merge!(
#   :views => File.join(File.dirname(__FILE__), 'views'),
#   :run => false,
#   :env => ENV['RACK_ENV']
# )

require 'main'
run Sinatra::Application