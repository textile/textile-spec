describe "Docs App" do
  
  def app
    Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
end