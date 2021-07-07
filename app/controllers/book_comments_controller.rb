class BookCommentsController < ApplicationController

	def create
		@books = Book.find(params[:book_id])
	  	@comment = BookComment.new(comment_params)
	    @comment.user_id = current_user.id
	    @comment.book_id = @books.id
	  	@comment.save
	end

	def destroy
		@comment = BookComment.find(params[:id])
		@books = Book.find(params[:book_id])
	    if @comment.user_id == current_user.id
			@comment.destroy
		else
      		redirect_to book_path(@book)
	    end
		@comments = @books.book_comments
	end

  private

  def comment_params
		params.require(:book_comment).permit(:comment)
  end

end
