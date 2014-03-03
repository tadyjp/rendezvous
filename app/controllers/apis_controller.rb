class ApisController < ApplicationController

  # TODO: not to use
  include ApplicationHelper

  def markdown_preview
    # TODO: not to use
    render text: h_application_format_markdown(params[:text] || '')
  end

  def file_receiver

    s3 = AWS::S3.new
    bucket = s3.buckets[Settings.s3.bucket_name]

    s3_file_urls = []

    params[:files].each do |file|
      basename = File.basename(file.path)
      o = bucket.objects[basename]
      out = o.write(:file => file.path)

      s3_file_urls << out.url_for(:read, expireds: 60).to_s
    end

    render json: { status: 'OK', urls: s3_file_urls }
  end
end

