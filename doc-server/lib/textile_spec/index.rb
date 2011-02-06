module TextileSpec
  class Index < OpenStruct
    include YamlCache
    attr_reader :file
    
    def initialize(yaml_uri=nil)
      @file = yaml_uri || self.class.remote_index_yaml_uri
      super(index_data)
    end
    
    def index_data
      load_yaml.tap do |index|
        index[:specs].map do |spec|
          spec.delete(spec['title'] = spec.key(nil))
          spec['file'] = expand_spec_path(spec['file'])
        end
      end
    end
    
    def specs
      @specs ||= SpecAssociation.new(@table[:specs])
    end
    
    def self.remote_index_yaml_uri
      "#{settings.root}/../spec/index.yaml"
    end
    
    def expand_spec_path(filename)
      File.join(File.dirname(self.file), filename)
    end
    
  end
end