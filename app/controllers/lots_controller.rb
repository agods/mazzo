class LotsController < ApplicationController
  
  def index
    @lots = Lot.all
  end

  def new
  	@lot = Lot.new
    @lot.design_applications.build
  end

  def create

  	@lot = Lot.new(lot_params)

  	if @lot.save
  	  redirect_to root_path
  	else
  	  render 'new'
  	end
  end

  private
  	def lot_params
  		params.require(:lot).permit(:name, design_applications_attributes:[:name, :address, :email, :phone, :work_address, :description,
  		 :start_date, :end_date, :image, :image_two, :image_three, :image_four, :image_five, :drawing, :tag_list, :note, :status, :approved])
  	end
end
