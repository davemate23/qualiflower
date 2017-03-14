CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    region:                'eu-west-2',                  # required
    aws_access_key_id:     'AKIAJDVMDYLYNBFKOMWQ',     # required
    aws_secret_access_key: 'AKIAJKZCMBOZLG2HRQSA'  # required
 
  }
  config.fog_directory  = ENV["fog_directory"]           # required
end