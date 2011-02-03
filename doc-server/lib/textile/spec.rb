module Textile
  class Spec
    def initialize(args)

    end

    def self.find(slug)
      name = slug.gsub('-', '_')
      load_spec(name)
    end
  
    def self.all
      index.map! do |document|
        document['examples'] = load_spec(document['file'])
        document
      end
    end
    
    def self.index
      load_spec('index').tap do |index|
        index.map do |document|
          document.delete(document['title'] = document.key(nil))
          document
        end
      end
    end
    
    def self.load_spec(name)
      unless file = settings.cache.get(cache_key_for_file(name))
        file = File.read("#{settings.root}/../spec/#{name}.yaml")
        settings.cache.set(cache_key_for_file(name), file)
      end
      YAML::load(file)
    end
    
    def self.cache_key_for_file(name)
      "file.#{name}"
    end
  end
end