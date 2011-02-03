describe Textile::Spec do
  shared_examples_for "index" do
    it "should retrieve all the documents" do
      documents.should be_an(Array)
      documents.should_not be_empty
    end
    
    it "should have a 'file' attribute on its documents" do
      documents.first.should have_key('file')
    end

    it "should have a 'title' attribute on its documents" do
      documents.first.should have_key('title')
    end
    
  end
  
  describe "#index" do
    let(:documents) { Textile::Spec.index }
    it_should_behave_like "index"
  end
  
  describe "#all" do
    let(:documents) { Textile::Spec.all }
    it_should_behave_like "index"
    
    it "should have examples in each document" do
      documents.each do |doc|
        doc.should have_key('examples')
        doc['examples'].should be_a(Array)
      end
    end
  end
  
  describe "#load_spec" do
    before(:each) do
      settings.cache.flush
    end
    
    it "should load the spec from a local yaml file" do
      File.should_receive(:read).with(/foo/).and_return("")
      Textile::Spec.load_spec('foo')
    end
    
    it "should load the spec from memcache" do
      File.should_receive(:read).once.and_return("")
      Textile::Spec.load_spec('foo')
      Textile::Spec.load_spec('foo') # Second time is from memcache
    end
  end
  
  describe "#find" do
    it "should convert dashes to underscores" do
      Textile::Spec.should_receive(:load_spec).with("page_layout")
      
      Textile::Spec.find("page-layout")
    end
  end
end