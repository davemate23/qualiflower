CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    region:                'eu-west-2',                  # required
    aws_access_key_id:     ENV["aws_access_key_id"],     # required
    aws_secret_access_key: ENV["aws_secret_access_key"]  # required
 
  }
  config.fog_directory  = ENV["fog_directory"]           # required
end