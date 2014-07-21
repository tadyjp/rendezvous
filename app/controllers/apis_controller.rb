require 'digest/md5'

class ApisController < ApplicationController

  # TODO: not to use
  include ApplicationHelper

  def markdown_preview
    # TODO: not to use
    render text: MarkdownRenderer.new(params[:text]).render
  end

  # Receive file and upload to S3
  def file_receiver
    s3 = AWS::S3.new
    bucket_name = "#{Settings.s3.bucket_name}/1/#{current_user.id}"
    # bucket_name = "1/#{current_user.id}"
    bucket = s3.buckets[bucket_name]

    s3_files = []

    params[:files].each do |file|
      basename = File.basename(file.path)

      next unless file.original_filename =~ /\.(jpe?g|png|gif|pdf)\Z/

      object_file_name = "#{Digest::MD5.file(file.path).to_s}#{File.extname(file.original_filename)}"
      obj = bucket.objects[object_file_name]

      res = obj.write(file: file.path, acl: :public_read)

      file_type = case file.original_filename
      when /\.(jpe?g|png|gif)\Z/
        :image
      when /\.pdf\Z/
        :slide
      end

      s3_files << { name: file.original_filename, url: res.public_url.to_s, type: file_type }
    end

    render json: { status: 'OK', files: s3_files }
  end

  def user_mention
    name_list = User.search(params[:q]).map{ |_user| "#{_user.nickname}[#{_user.name}]" }

    render json: name_list
  end
end
