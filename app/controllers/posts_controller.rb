class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :is_organizer!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :is_owner, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(organization_id: current_user.organization.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show  
    @comments = @post.comments.order(created_at: :desc).includes(:user)
    @new_comment = @post.comments.build(user: current_user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params.merge(organization_id: current_user.organization.id))

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :organization_id)
    end

    def is_owner
      if @post.organization_id != current_user.organization.id
        raise AuthorizationException
      end
    end
end
