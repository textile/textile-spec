module TextileSpec
  class SpecAssociation < Array
    
    def initialize(specs)
      super(specs.map do |data|
        Spec.new(data)
      end)
    end
    
    def find(slug)
      file_name = slug.gsub('-', '_')
      self.detect {|spec| spec.file.match(file_name) }
    end
  end
end