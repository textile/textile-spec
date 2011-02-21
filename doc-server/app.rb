set :root, File.dirname(__FILE__)

require 'dalli'
set :cache, Dalli::Client.new('localhost:11211', :compression => true)

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'textile_spec'
TextileSpec::Index.remote_index_yaml_uri = "#{settings.root}/../spec/index.yaml"

layout 'layout'
set :haml, :format => :html5

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

### Public

get '/' do
  @index = TextileSpec::Index.new
  @documents = @index.specs
  haml :index
end

get '/stylesheets/:filename.css' do
  scss :"stylesheets/#{params[:filename]}"
end

post '/specs/flush/?' do
  settings.cache.flush
  halt "Cache flushed."
end

get '/:slug/?' do
  @spec = TextileSpec.find(params[:slug])
  halt(404, "Page not found") unless @spec
  haml :document
end