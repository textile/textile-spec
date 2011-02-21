describe TextileSpec::Spec do
  before(:each) do
    settings.cache.flush
  end
  
  let(:index) { TextileSpec::Index.new }
  let(:spec) { index.specs.first }
  
  describe "with lazy spec loading" do    
    it "should get its metadata from the index" do
      TextileSpec::Spec.should_not_receive(:load_yaml)
    end
  end
  
  describe "#examples" do
    subject { spec.examples }
    it { should be_a(Hash) }
  end
  
  it "should have a #slug" do
    spec.slug.should == "paragraph-text"
  end
  
end