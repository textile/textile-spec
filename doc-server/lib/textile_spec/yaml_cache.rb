module TextileSpec
  module YamlCache
    def load_yaml
      unless file_contents = settings.cache.get(file)
        file_contents = open(file) { |f| f.read }
        raise "Spec yaml file missing or empty." if file_contents.nil? || file_contents == ''
        settings.cache.set(file, file_contents)
      end
      YAML::load(file_contents)
    end

  end
end