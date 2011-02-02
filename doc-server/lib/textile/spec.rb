module Textile
  class Spec
    def initialize(args)

    end

    def self.find(slug)
      file = slug.gsub('-', '_')
    end
  
    def self.all
      index.map! do |document|
        document['examples'] = YAML::load(File.open("#{settings.root}/../spec/#{document['file']}.yaml"))
        document
      end
    end
    
    def self.index
      YAML::load(File.open("#{settings.root}/../spec/index.yaml")).tap do |index|
        index.map do |document|
          document.delete(document['title'] = document.key(nil))
        end
      end
      # settings.cache.set('index', )
    end
  end
end