Sidekiq.configure_server do |config|
   config.redis = { url: 'redis://h:p499797503f6a6002bb9ed05d581700fbbad567726d3c455c5bf5bfb291635af4@ec2-34-251-82-220.eu-west-1.compute.amazonaws.com:23939' }
   config.redis = { :size => 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://h:p499797503f6a6002bb9ed05d581700fbbad567726d3c455c5bf5bfb291635af4@ec2-34-251-82-220.eu-west-1.compute.amazonaws.com:23939' }
  config.redis = { size: 1 }
end

