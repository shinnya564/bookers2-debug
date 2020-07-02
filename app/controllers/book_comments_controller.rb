class BookCommentsController < ApplicationController

	def create
		book = Book.find(params[:book_id])
	  	@comment = BookComment.new(comment_params)
	    @comment.user_id = current_user.id
	    @comment.book_id = book.id
	  	if @comment.save
	  		redirect_to book_path(book), notice: "successfully created book!"
	  	else
	  		@book = book
	  		@user = book.user
	  		render template: 'books/show'
	  	end
	end

	def destroy
	end

  private

  def comment_params
  	params.require(:book_comment).permit(:comment)
  end

end
