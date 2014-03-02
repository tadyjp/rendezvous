class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag.show_path, flash: { notice: 'Tag was successfully created.' } }
        format.json { render action: 'show', status: :created, location: @tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag.show_path, flash: { notice: 'Tag was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, flash: { success: 'Tag successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  def merge_to
    @merge_to_tag = Tag.find_by(name: params[:merge_to_name]) or raise ActiveRecord::RecordNotFound

    @tag.move_all_posts_to!(@merge_to_tag)
    @tag.delete

    render json: { status: 'OK' }
  end

  private

  def set_tag
    tag = Tag.find_by(name: params[:name]) or raise ActiveRecord::RecordNotFound
    @tag = tag.decorate
  end

  def tag_params
    params.require(:tag).permit(:name, :body).to_hash
  end

end
