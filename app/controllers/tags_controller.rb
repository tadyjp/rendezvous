class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :merge_to, :move_to, :events]

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def events
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        gflash success: 'Tag was successfully created.'
        format.html { redirect_to @tag.show_path }
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
        gflash success: 'Tag was successfully updated.'
        format.html { redirect_to @tag.show_path }
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
      gflash success: 'Tag successfully deleted.'
      format.html { redirect_to flow_url }
      format.json { head :no_content }
    end
  end

  # このタグを他のタグにマージ
  #   すべてのPostを移動先のタグに移動し
  #   このタグを削除する
  def merge_to
    @merge_to_tag = Tag.find_by(name: params[:merge_to_name]) or fail ActiveRecord::RecordNotFound

    @tag.move_all_posts_to!(@merge_to_tag)
    @tag.delete

   gflash success: "「#{@tag.name}」は「#{@merge_to_tag.name}」にmergeされました"

    render json: { status: 'OK' }
  end

  # このタグを他のタグの下に移動
  def move_to
    @move_to_tag = Tag.find_by(name: params[:move_to_name]) or fail ActiveRecord::RecordNotFound

    @tag.parent_tag = @move_to_tag

    gflash success: "「#{@tag.name}」は「#{@move_to_tag.name}」の下に移動しました"

    render json: { status: 'OK' }
  end

  private

  def set_tag
    tag = Tag.find_by(name: params[:name]) or fail ActiveRecord::RecordNotFound
    @tag = tag.decorate
  end

  def tag_params
    params.require(:tag).permit(:name, :body).to_hash
  end
end
