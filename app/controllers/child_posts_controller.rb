class ChildPostsController < ApplicationController
  before_action :set_child_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  include ApplicationHelper
  

  # GET /child_posts
  # GET /child_posts.json
  def index
    @child_posts = ChildPost.all
  end

  # GET /child_posts/1
  # GET /child_posts/1.json
  def show
    @board = @child_post.root_post.board
  end

  # GET /child_posts/new
  def new
    @child_post = current_user.child_posts.build
  end

  # GET /child_posts/1/edit
  def edit
  end

  # POST /child_posts
  # POST /child_posts.json
  def create
    @child_post = current_user.child_posts.build(child_post_params)

    respond_to do |format|
      if @child_post.save
        format.html { redirect_to [@child_post.root_post.board, @child_post.root_post], notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @child_post }
      else
        format.html { render :new }
        format.json { render json: @child_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /child_posts/1
  # PATCH/PUT /child_posts/1.json
  def update
    respond_to do |format|
      if @child_post.update(child_post_params)
        format.html { redirect_to [@child_post.root_post.board, @child_post.root_post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @child_post }
      else
        format.html { render :edit }
        format.json { render json: @child_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /child_posts/1
  # DELETE /child_posts/1.json
  def destroy
    @child_post.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: [@child_post.root_post.board, @child_post.root_post], notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child_post
      @child_post = ChildPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_post_params
      params.require(:child_post).permit(:body, :picture, :root_post_id)
    end
end
