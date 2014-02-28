class TagsController < ApplicationController
  layout 'app'

  def show
    @tag = Tag.find_by(tag_params)
    @posts = @tag.posts
  end

  private

  def tag_params
    params.permit(:name).to_hash
  end

end
