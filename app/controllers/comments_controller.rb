class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@commentable = find_commentable
		@comment = @commentable.comments.new(comments_params)
		@comment.user = current_user
		if @comment.save
			flash[:notice] = "Successfully created comment."
			redirect_to @commentable
		else
			flash[:error] = "Error adding comment."
		end
	end

	def new
		@parent_id = params.delete(:parent_id)
		@commentable = find_commentable
		@comment = Comment.new(parent_id: @parent_id, commentable_id: @commentable_id, commentable_type: @commentable.class.to_s)
	end

	private

	def find_commentable
		params.each do |name, value|
			if name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
		nil
	end

	def comments_params
		params.require(:comment).permit(:content, :commentable, :ancestry)
	end
end