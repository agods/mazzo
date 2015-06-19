class DesignApplicationsController < ApplicationController
  def index
  	@design_applications = DesignApplication.paginate(page: params[:page], :per_page => 5)
  end

  def show
  	@design_application = DesignApplication.find(params[:id])
    @comment = Comment.new(parent_id: params[:parent_id], design_application_id: @design_application.id)
    @comments = Comment.where(design_application: @design_application).hash_tree
  end

  def new
  	@design_application = DesignApplication.new
  end

  def create
  	@design_application = DesignApplication.new(design_application_params)

  	if @design_application.save
  	  redirect_to @design_application
  	else
  	  render 'new'
  	end
  end

  def upvote
    @design_application = DesignApplication.find(params[:id])
    @design_application.upvote_by current_user
    redirect_to @design_application
  end

  def downvote
    @design_application = DesignApplication.find(params[:id])
    @design_application.downvote_by current_user
    redirect_to @design_application
  end

  private
  	def design_application_params
  		params.require(:design_application).permit(:name, :address, :email, :phone, :work_address, :description,
  		 :start_date, :end_date, :image, :drawing, neighbors_attributes:[:id, :name, :address, :email, :phone, :_destroy])
  	end
end
