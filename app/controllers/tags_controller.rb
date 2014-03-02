class TagsController < ApplicationController
  layout 'app'

  def show
    @tag = Tag.find_by(tag_params)
    @posts = @tag.posts
  end

  def merge_to
    @tag = Tag.find_by(tag_params) or raise ActiveRecord::RecordNotFound
    @merge_to_tag = Tag.find_by(name: params[:merge_to_name]) or raise ActiveRecord::RecordNotFound

    @tag.move_all_posts_to!(@merge_to_tag)
    @tag.delete

    render json: { status: 'OK' }
  end

  private

  def tag_params
    params.permit(:name).to_hash
  end

end
