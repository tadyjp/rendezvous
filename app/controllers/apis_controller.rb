require 'digest/md5'

class ApisController < ApplicationController
  # TODO: not to use
  include ApplicationHelper

  def markdown_preview
    # TODO: not to use
    render text: MarkdownRenderer.new(params[:text]).render
  end

  # Receive file and upload to S3
  # @response [JSON]
  #  { "status": "OK",
  #    "files": [
  #      { "name": <file name>, "url": <link url>, "image": <image url>, "type": <file type>}, ...
  #     ]
  #  }
  def file_receiver
    s3_uploader = S3Uploader.new(bucket: "#{Settings.s3.bucket_name}/1/#{current_user.id}")

    s3_files = []

    params[:files].each do |file|
      # Skip uploading if file ext is not listed.
      next unless file.original_filename =~ /\.(jpe?g|png|gif|pdf)\Z/

      object_file_name = "#{Digest::MD5.file(file.path)}#{File.extname(file.original_filename)}"
      res = s3_uploader.upload!(file: file.path, name: object_file_name)

      case file.original_filename
      when /\.(jpe?g|png|gif)\Z/
        s3_files << { type: 'image', name: file.original_filename, image: res.public_url.to_s }
      when /\.pdf\Z/
        if Settings.enable_pdf_uploading
          cover_image_name = "#{Digest::MD5.file(file.path)}-cover.png"
          pdf = Magick::ImageList.new(file.path + '[0]')
          cover_tmp = Rails.root.join('tmp', cover_image_name)
          pdf[0].write(cover_tmp)
          cover_res = s3_uploader.upload!(file: cover_tmp, name: cover_image_name)

          s3_files << { type: 'slide', name: cover_image_name, url: res.public_url.to_s, image: cover_res.public_url.to_s }
        end
      end
    end

    render json: { status: 'OK', files: s3_files, uploading_index: params[:uploading_index] }
  end

  def user_mention
    name_list = User.search(params[:q]).map { |user| "#{user.nickname}[#{user.name}]" }

    render json: name_list
  end
end
