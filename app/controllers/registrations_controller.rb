class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:preferences]

  def preferences
    render :preferences
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
