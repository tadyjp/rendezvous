CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = 'rendezvous-uploads'
  config.aws_acl    = :private
  # config.asset_host = 'http://example.com'
  config.aws_authenticated_url_expiration = 60 * 1

  config.aws_credentials = {
    access_key_id:     Settings.s3.access_key_id,
    secret_access_key: Settings.s3.secret_access_key,
    config:            AWS.config(region: 'ap-northeast-1')
  }
end
