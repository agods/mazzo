class CommentsController < ApplicationController
  def index
  	@comments = Comment.hash_tree
  end

  def new
  	@comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
  	@design_application = DesignApplication.find(params[:comment][:design_application_id])
  	if params[:comment][:parent_id].to_i > 0
  		parent = Comment.find_by_id(params[:comment].delete(:parent_id))
  		@comment = parent.children.build(comment_params)
  		current_user.comments << @comment
  	else
  		@comment = current_user.comments.build(comment_params)
  	end

  	if @comment.save
  		flash[:success] = "Your comment was successfully added"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  private

  	def comment_params
  		params.require(:comment).permit(:title, :body, :parent_id, :design_application_id)
  	end
end
