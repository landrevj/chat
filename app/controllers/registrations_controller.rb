class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:preferences]

  def preferences
    render :preferences
  end

  def details
    render :details
  end

  def threads
    @stickies = current_user.root_posts.where('properties @> ?', {sticky: true}.to_json).order(created_at: :desc)
    @root_posts = current_user.root_posts.where('properties @> ?', {sticky: false}.to_json).order(created_at: :desc)
    render :threads
  end

  def posts
    @child_posts = current_user.child_posts.order(created_at: :desc)
    render :posts
  end

  protected 

  # courtesy of https://www.mnishiguchi.com/2017/11/24/rails-devise-edit-account-without-password/
  def update_resource(resource, params)
    return super if params["password"].present?
    resource.update_without_password(params.except("current_password"))
  end

  private

  def set_user
    @user = current_user
  end
end
