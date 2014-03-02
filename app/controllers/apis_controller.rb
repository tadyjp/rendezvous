class ApisController < ApplicationController

  # TODO: not to use
  include ApplicationHelper

  def markdown_preview
    # TODO: not to use
    render text: h_application_format_markdown(params[:text] || '')
  end
end

