class UserCredsController < ApplicationController

  def moderate
    @user_creds = UserCredsController.where(:approved: false)
  end

  def approve
    @user_cred = UserCredsController.find(params[:id])
    @user_cred.approved= true
    @user_cred.save()

  def delete
    @user_cred = UserCredsController.find(params[:id])
    @user_cred.destroy()
  end

  def new
    @user_cred = UserCred.new()
  end

  def create
    @user_cred = User.new(create_update_params)
    @user_cred.user_id = current_user.id

    respond_to do |format|
      if @user_cred.save
        format.html { redirect_to user_path(current_user.id), notice: 'Professor credential request created successfully'}
        format.turbo_stream
      else
        format.html do 
          flash[:alert] = 'Professor credential request could not be created'
          render :new, status: :unprocessable_content
        end
      end
    end
  end

  private
  
  def create_update_params    
    params.require(:sight_cred).permit(:details, :name,:school)
  end
end
