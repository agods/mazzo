class DesignApplicationsController < ApplicationController
  before_action :authenticate_user!, :except => [:create, :new, :show]


  def index
  	@filterrific = initialize_filterrific(
      DesignApplication,
      params[:filterrific],
      :select_options => {
        sorted_by: DesignApplication.options_for_sorted_by,
        with_status: DesignApplication.options_for_select,
        with_approved: DesignApplication.options_for_select
      }
    ) or return
    @design_applications = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
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
  	  redirect_to root_path
  	else
  	  render 'new'
  	end
  end

  def update
    @design_application = DesignApplication.find(params[:id])
    if @design_application.update_attributes(design_application_params)
      redirect_to design_applications_path, :notice => "Design App Updated."
    else
      redirect_to design_applications_path, :alert => "Unable to update Design App."
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

  def approve
    @design_application = DesignApplication.find(params[:id])
    if @design_application.update_attributes(approved: 1, status: 0)
      redirect_to root_path, :notice => "Design App Approved."
    else
      redirect_to root_path, :alert => "Something went wrong."
    end
  end

  def reject
    @design_application = DesignApplication.find(params[:id])
    if @design_application.update_attributes(approved: 0, status: 0)
      redirect_to root_path, :notice => "Design App Rejected."
    else
      redirect_to root_path, :notice => "Something went wrong"
    end
  end


  private
  	def design_application_params
  		params.require(:design_application).permit(:name, :address, :email, :phone, :work_address, :description,
  		 :start_date, :end_date, :image, :image_two, :image_three, :image_four, :image_five, :drawing, :tag_list, :note, :status, :approved, neighbors_attributes:[:id, :name, :address, :email, :phone, :_destroy])
  	end
end
