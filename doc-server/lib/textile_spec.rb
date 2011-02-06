require 'ostruct'
require 'open-uri'
require 'textile_spec/yaml_cache'
require 'textile_spec/index'
require 'textile_spec/spec_association'
require 'textile_spec/spec'

module TextileSpec
  def self.specs
    Index.new.specs
  end
  
  def self.find(slug)
    specs.find(slug)
  end
end