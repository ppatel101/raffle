class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        type_count = User.where(type_id: @user.type_id)
        format.html { redirect_to new_user_path, notice: "Thanks for signing up! Your odds of winning are #{(100/type_count.count.to_f).round(2)}%." }
      else
        @user.errors.full_messages.each do |msg|
          format.html { redirect_to new_user_path, alert: "#{msg}"}
        end
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :type_id)
  end
end