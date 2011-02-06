module TextileSpec
  class SpecAssociation < Array
    
    def initialize(specs)
      specs.map! {|data| Spec.new(data) }
      super(specs)
    end
    
    def find(slug)
      file_name = slug.gsub('-', '_')
      self.detect {|spec| spec.file.match(file_name) }
    end
  end
end