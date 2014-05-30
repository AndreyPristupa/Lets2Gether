class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_profile
  # GET /profiles
  # GET /profiles.json
  def index
    redirect_to update_profile_path unless current_user.firstname || current_user.lastname
    @user = current_user
    slug = nil
    if params[:slug]
      slug = "profiles/partials/#{params[:slug]}"
    end
    @slug = slug
  end

  def update
    @user = @profile

    if request.put?
      user =  User.find(@user.id)
      respond_to do |format|
        if user.update(profile_params)
          format.json {render json: @user, status: :ok}
        else
          format.json {render json: user.errors, status: :unprocessable_entity}
        end
      end
    end
  end

  def get_user_id
    @profile.id
  end

private
  def set_profile
    @profile = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:firstname,:lastname,:slogan,:image)
  end
end