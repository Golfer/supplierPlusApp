class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = current_user.admin? ? User.all : current_user
  end

  # GET /users/1 or /users/1.json
  def show; end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
