set :root, File.dirname(__FILE__)

require 'dalli'
set :cache, Dalli::Client.new('localhost:11211', :compression => true)

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'textile_spec'
TextileSpec::Index.remote_index_yaml_uri = "#{settings.root}/../spec/index.yaml"

layout 'layout'
set :haml, :format => :html5

### Public

get '/' do
  @documents = TextileSpec.specs
  haml :index
end

get '/:slug/?' do
  @spec = TextileSpec.find(params[:slug])
  halt(404, "Page not found") unless @spec
  haml :document
end

post '/specs/flush/?' do
  settings.cache.flush
  halt "Cache flushed."
end