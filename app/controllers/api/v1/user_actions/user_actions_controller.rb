class Api::V1::UserActions::UserActionsController < Api::V1::ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource :proposition

  def create
    @user_action = model_class.find_or_create_by(proposition: @proposition, user: current_user)
    respond_with @user_action, location: nil
  end

  def destroy
    @user_action = model_class.find_by(proposition: @proposition, user: current_user)
    @user_action.destroy
    respond_with @user_action, location: nil
  end

  protected
  def model_class
    "UserAction::#{params[:controller].split('/').last.singularize.camelcase}".constantize
  end
end
