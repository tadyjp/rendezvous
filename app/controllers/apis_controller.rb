require 'digest/md5'

class ApisController < ApplicationController

  # TODO: not to use
  include ApplicationHelper

  def markdown_preview
    # TODO: not to use
    render text: h_application_format_markdown(params[:text] || '')
  end

  def file_receiver

    s3 = AWS::S3.new
    bucket_name = "#{Settings.s3.bucket_name}/1/#{current_user.id}"
    # bucket_name = "1/#{current_user.id}"
    bucket = s3.buckets[bucket_name]

    s3_files = []

    params[:files].each do |file|
      basename = File.basename(file.path)

      object_file_name = "#{Digest::MD5.file(file.path).to_s}#{File.extname(file.original_filename)}"
      obj = bucket.objects[object_file_name]

      res = obj.write(file: file.path, acl: :public_read)

      s3_files << { name: file.original_filename, url: res.public_url.to_s }
    end

    render json: { status: 'OK', files: s3_files }
  end
end
