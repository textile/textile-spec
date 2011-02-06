set :root, File.dirname(__FILE__)

require 'sinatra-sindalli'
set :cache, Dalli::Client.new('localhost:11211', :compression => true)

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'textile_spec'

layout 'layout'
set :haml, :format => :html5

### Public

get '/' do
  @documents = TextileSpec.specs
  haml :index
end

get '/:slug/' do
  @spec = TextileSpec.find(params[:slug])
  halt(404, "Page not found") unless @spec
  haml :document
end

# get '/past/:year/:month/:day/:slug/' do
#   post = Post.filter(:slug => params[:slug]).first
#   stop [ 404, "Page not found" ] unless post
#   @title = post.title
#   erb :post, :locals => { :post => post }
# end
# 
# get '/past/:year/:month/:day/:slug' do
#   redirect "/past/#{params[:year]}/#{params[:month]}/#{params[:day]}/#{params[:slug]}/", 301
# end
# 
# get '/past' do
#   posts = Post.reverse_order(:created_at)
#   @title = "Archive"
#   erb :archive, :locals => { :posts => posts }
# end
# 
# get '/past/tags/:tag' do
#   tag = params[:tag]
#   posts = Post.filter(:tags.like("%#{tag}%")).reverse_order(:created_at).limit(30)
#   @title = "Posts tagged #{tag}"
#   erb :tagged, :locals => { :posts => posts, :tag => tag }
# end
# 
# get '/feed' do
#   @posts = Post.reverse_order(:created_at).limit(20)
#   content_type 'application/atom+xml', :charset => 'utf-8'
#   builder :feed
# end
# 
# get '/rss' do
#   redirect '/feed', 301
# end
# 
# ### Admin
# 
# get '/auth' do
#   erb :auth
# end
# 
# post '/auth' do
#   set_cookie(Blog.admin_cookie_key, Blog.admin_cookie_value) if params[:password] == Blog.admin_password
#   redirect '/'
# end
# 
# get '/posts/new' do
#   auth
#   erb :edit, :locals => { :post => Post.new, :url => '/posts' }
# end
# 
# post '/posts' do
#   auth
#   post = Post.new :title => params[:title], :tags => params[:tags], :body => params[:body], :created_at => Time.now, :slug => Post.make_slug(params[:title])
#   post.save
#   redirect post.url
# end
# 
# get '/past/:year/:month/:day/:slug/edit' do
#   auth
#   post = Post.filter(:slug => params[:slug]).first
#   stop [ 404, "Page not found" ] unless post
#   erb :edit, :locals => { :post => post, :url => post.url }
# end
# 
# post '/past/:year/:month/:day/:slug/' do
#   auth
#   post = Post.filter(:slug => params[:slug]).first
#   stop [ 404, "Page not found" ] unless post
#   post.title = params[:title]
#   post.tags = params[:tags]
#   post.body = params[:body]
#   post.save
#   redirect post.url
# end
