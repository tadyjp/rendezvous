class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]

  include ApplicationHelper

  # GET /posts
  # GET /posts.json
  def index
    if user_signed_in?

      if params[:q].present?
        @posts = Post.build_query(params).limit(10)
      else
        @posts = Post.order(updated_at: :desc).limit(10)
      end

      render
    else
      render file: 'home/login'
    end
  end

  def preview
    render text: h_application_format_markdown(params[:text])
  end

  def show_fragment
    @post = Post.find(params[:id])
    render layout: false, partial: 'posts/show_fragment'
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def fork
    @post = set_post.clone
    @post.title = @post.title.gsub(/%Name/, current_user.name)
    @post.title = Time.now.strftime(@post.title) # TODO
    render action: 'new'
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.author = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path(id: @post.id), notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.author = current_user

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path(id: @post.id), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      @post_params ||= begin
        _param_hash = params.require(:post).permit(:title, :body, :tags).to_hash

        # tags_text == 'Javascript,Ruby'
        tags_text = _param_hash.delete('tags')

        tags = tags_text.split(',').map do |_tag_name|
          Tag.find_or_create_by(name: _tag_name)
        end
        _param_hash["tag_ids"] = tags.map(&:id)

        _param_hash
      end
    end
end
