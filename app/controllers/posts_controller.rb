require 'nkf'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :slideshow, :watch]

  include RV::Mailer

  # GET /posts/1
  # GET /posts/1.json
  def show
    current_user.visit_post!(@post)

    @post.tags.each do |_tag|
      add_breadcrumb("##{_tag.name}", _tag.decorate.show_path)
    end
    add_breadcrumb(@post.title)
  end

  # GET /posts/new
  def new
    @post = Post.new(title: '新しい投稿')
  end

  def fork
    @post = set_post.generate_fork(current_user)
    render action: 'new'
  end

  def mail
    @post = set_post

    # refresh google oauth token if expired
    current_user.google_oauth_token_refresh! if current_user.google_oauth_token_expired?

    compose_mail(@post, user: current_user, to: mail_params[:to]).deliver
    redirect_to root_path(id: @post.id), flash: { success: 'Mail has sent!' }
  rescue ActionGmailer::DeliveryError
    redirect_to root_path(id: @post.id), flash: { notice: 'Gmail authentication expired.' }
  rescue ArgumentError => err
    redirect_to root_path(id: @post.id), flash: { alert: 'Mail format is invalid: ' + err.to_s }
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
        format.html { redirect_to post_path(id: @post.id), flash: { notice: 'Post was successfully created.' } }
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
        format.html { redirect_to post_path(id: @post.id), flash: { notice: 'Post was successfully updated.' } }
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
      format.html { redirect_to posts_url, flash: { success: 'Post successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  # POST /posts/1/comment
  def comment
    @post = set_post
    @comment = @post.comments.build(comment_params.merge(author: current_user))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(id: @post.id) }
        format.json { render json: { status: 'ok', comment: @comment }, status: :created }
      else
        format.html { redirect_to post_path(id: @post.id), flash: { alert: 'Comment is not saved.' } }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Show presentation view
  def slideshow
    render layout: 'slideshow'
  end

  def watch
    if current_user.watching?(post: @post)
      current_user.unwatch!(post: @post)
    else
      current_user.watch!(post: @post)
    end

    respond_to do |format|
      format.html { render action: :show, layout: false }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    @post_params ||= begin
      _param_hash = params.require(:post).permit(:title, :body, :tags, :is_draft, :specified_date).to_hash

      # tags_text == 'Javascript,Ruby'
      tags_text = _param_hash.delete('tags')

      tags = tags_text.split(',').map do |_tag_name|
        Tag.find_or_create_by(name: _tag_name)
      end
      _param_hash['tag_ids'] = tags.map(&:id)

      _param_hash
    end
  end

  def mail_params
    params.require(:mail).permit(:to).to_hash.symbolize_keys
  end

  def comment_params
    params.require(:comment).permit(:body).to_hash
  end
end
