class S3Uploader
  # Preparing S3 object and bucket.
  # @param [String] access_key_id.
  # @param [String] secret_access_key.
  # @param [String] region: uploading S3 bucket region.
  # @param [String] bucket: uploading backet name.
  def initialize(access_key_id: Settings.s3.access_key_id,
                 secret_access_key: Settings.s3.secret_access_key,
                 region: 'ap-northeast-1',
                 bucket:)
    @s3 = AWS::S3.new(access_key_id: access_key_id,
                      secret_access_key: secret_access_key,
                      region: region)
    @bucket = @s3.buckets[bucket]
  end

  # Upload file to S3
  # @param [String] file: uploading file path.
  # @param [String] name: uploading file name.
  def upload!(file:, name:)
    obj = @bucket.objects[name]
    obj.write(file: file, acl: :public_read)
  end
end
