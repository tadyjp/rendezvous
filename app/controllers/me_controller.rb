class MeController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @me.update(user_params)
        format.html { redirect_to edit_me_path, flash: { notice: 'Post was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @me.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @me = current_user
  end

  def user_params
    params.require(:user).permit(:nickname).to_hash
  end
end
