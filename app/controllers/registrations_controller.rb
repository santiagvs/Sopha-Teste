class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      # User registration was successful
      render json: resource, status: :created
    else
      # User registration failed
      render json: { errors: resource.errors.full_messages }, status: :bad_request
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
