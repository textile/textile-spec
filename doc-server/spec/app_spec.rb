describe "Docs App" do
  
  def app
    Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
  
  it "should get a spec at /spec_name/" do
    get '/paragraph_text/'
    last_response.should be_ok
  end
  
  it "should return a 404 on /invalid-spec-name/" do
    get '/foo-bar-baz/'
    last_response.should_not be_ok
  end
  
  it "should clear the cache on /specs/flush/" do
    get '/'
    expect {
      post '/specs/flush/'
    }.to change { settings.cache.get(TextileSpec::Index.remote_index_yaml_uri) }.to(nil)
    
  end
end