class RootPostsController < ApplicationController
  before_action :set_root_post, only: [:show, :edit, :update, :destroy]

  # GET /root_posts
  # GET /root_posts.json
  def index
    @root_posts = RootPost.all
  end

  # GET /root_posts/1
  # GET /root_posts/1.json
  def show
    @child_posts = @root_post.child_posts.all
    @child_post = @root_post.child_posts.build
  end

  # GET /root_posts/new
  def new
    @root_post = RootPost.new
  end

  # GET /root_posts/1/edit
  def edit
  end

  # POST /root_posts
  # POST /root_posts.json
  def create
    @root_post = RootPost.new(root_post_params)

    respond_to do |format|
      if @root_post.save
        format.html { redirect_to @root_post, notice: 'Root post was successfully created.' }
        format.json { render :show, status: :created, location: @root_post }
      else
        format.html { render :new }
        format.json { render json: @root_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /root_posts/1
  # PATCH/PUT /root_posts/1.json
  def update
    respond_to do |format|
      if @root_post.update(root_post_params)
        format.html { redirect_to @root_post, notice: 'Root post was successfully updated.' }
        format.json { render :show, status: :ok, location: @root_post }
      else
        format.html { render :edit }
        format.json { render json: @root_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /root_posts/1
  # DELETE /root_posts/1.json
  def destroy
    @root_post.destroy
    respond_to do |format|
      format.html { redirect_to root_posts_url, notice: 'Root post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_root_post
      @root_post = RootPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def root_post_params
      params.require(:root_post).permit(:subject, :body, :picture)
    end
end
