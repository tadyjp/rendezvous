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
      # TODO rename file name

      # http://soplana.hateblo.jp/entry/%E2%96%A0

      s3_file_urls << out.url_for(:read).to_s
    end

    render json: { status: 'OK', urls: s3_file_urls }
  end
end

