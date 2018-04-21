class RootPostsController < ApplicationController
  before_action :set_root_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  include ApplicationHelper

  # GET /root_posts
  # GET /root_posts.json
  def index
    @root_posts = RootPost.all.order(created_at: :desc)
  end

  # GET /root_posts/1
  # GET /root_posts/1.json
  def show
    @board = @root_post.board
    @child_posts = @root_post.child_posts.all.order(created_at: :asc)
    @child_post = @root_post.child_posts.build
  end

  # GET /root_posts/new
  def new
    @board = @root_post.board
    @root_post = current_user.root_posts.build
  end

  # GET /root_posts/1/edit
  def edit
    @board = @root_post.board
  end

  # POST /root_posts
  # POST /root_posts.json
  def create
    @root_post = current_user.root_posts.build(root_post_params)
    @board = @root_post.board

    respond_to do |format|
      if @root_post.save
        propagate_replies(@root_post)
        format.html { redirect_to [@root_post.board, @root_post], notice: 'Thread was successfully created.' }
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
        format.html { redirect_to [@root_post.board, @root_post], notice: 'Thread was successfully updated.' }
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
      format.html { redirect_to @root_post.board, notice: 'Thread was successfully destroyed.' }
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
    params.require(:root_post).permit(:subject, :body, :picture, :board_id)
  end

  # Add root_post.id to the properties of each post it quotes.
  def propagate_replies(root_post)
    text = root_post.body
    post = nil
    text.gsub(/@(#+)(\d+)/) do
      begin
        id = $2.to_i
        if $1 == '##'
          post = RootPost.find(id)
        elsif $1 == '#'
          post = ChildPost.find(id)
        end

        post.root_reply_ids = post.root_reply_ids.push(root_post.id)
        post.save(touch: false)

      rescue ActiveRecord::RecordNotFound
      end
    end
  end
end
