class NotificationsController < ApplicationController
  before_action :set_notification, only: [:bridge]

  def bridge
    @notification.set_read!
    redirect_to @notification.detail_path
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
