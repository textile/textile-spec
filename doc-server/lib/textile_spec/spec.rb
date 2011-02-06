module TextileSpec
  class Spec < OpenStruct
    include YamlCache
    
    def examples
      @examples ||= load_yaml
    end
    
    def slug
      File.basename(file).gsub('_','-').gsub(/\.ya?ml/, '')
    end
    
  end
end