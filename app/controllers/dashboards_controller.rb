class DashboardsController < ApplicationController

	def index
		@notifications = Notification.where(read: false)
	end

	def update
		@notification = Notification.find(params[:id])
		if @notification.update_attributes(notification_params)
			redirect_to root_path
		else
			redirect_to root_path, :alert => "Unable to remove notification."
		end
	end

  
	private

		def notification_params
			params.require(:notification).permit(:comment_id,:read)
		end

end
