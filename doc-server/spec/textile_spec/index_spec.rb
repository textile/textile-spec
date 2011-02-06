describe TextileSpec::Index do
  before(:each) do
    settings.cache.flush
  end
  let(:index) { TextileSpec::Index.new(index_fixture_path) }
  
  describe "#version" do
    subject { index.version }
    it { should be_a(String) }
    it { should_not be_nil }
  end
  
  describe "#specs" do
    subject { index.specs }
    
    it { should be_kind_of(Array) }
    it { should_not be_empty }
    
    it "should each have a file attribute" do
      subject.first.should respond_to('file')
      subject.first.file.should match("paragraph_text.yaml")
    end

    it "should each have a title attribute" do
      subject.first.should respond_to('title')
      subject.first.title.should == "Writing Paragraph Text"
    end
    
    it "should each have examples" do
      subject.first.should respond_to('examples')
      subject.first.examples.should be_an(Array)
    end
  end
  
  describe "specs.find" do
    let(:specs) { index.specs }

    it "should find a spec" do
      specs.find("paragraph_text").should be_a(TextileSpec::Spec)
    end
    
    it "should return nil when spec not found" do
      specs.find("foo").should be_nil
    end
    
    it "should convert slug to filename" do
      specs.find("paragraph-text").should_not be_nil
    end
  end
  
  describe "#load_yaml" do
    it "should set the data in the cache the first time" do
      expect {
        TextileSpec::Index.new(index_fixture_path)
      }.to change { settings.cache.get(index_fixture_path) }
    end
    
    it "should subsequently load the data from the cache, not file" do
      index = TextileSpec::Index.new(index_fixture_path) # First time is from file
      index.should_not_receive(:open)
      index.load_yaml # Second time is from memcache
    end
  end
  
end