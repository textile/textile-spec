namespace :memcache do
  desc "Clear memcache"
  task :flush do
    cache = Dalli::Client.new('localhost:11211', :compression => true)
    cache.flush
  end
end