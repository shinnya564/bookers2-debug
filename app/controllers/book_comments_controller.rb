class BookCommentsController < ApplicationController

	def create
		@books = Book.find(params[:book_id])
	  	@comment = BookComment.new(comment_params)
	    @comment.user_id = current_user.id
	    @comment.book_id = @books.id
	  	if @comment.save
	  		respond_to do |format|
		  		format.html {redirect_back(fallback_location: root_url)}
	     		format.js
	     	end
	  	else
	  		@book = Book.new
    		@books = Book.find(params[:book_id])
    		@user = @books.user
   			@comment = BookComment.new
	    	@comments = @books.book_comments
	  		render template: "books/show"
	  	end
	end

	def destroy
		@comment = BookComment.find(params[:book_id])
		@book = Book.find(params[:id])
	    if @comment.user_id == current_user.id
			@comment.destroy
			respond_to do |format|
		  		format.html {redirect_back(fallback_location: root_url)}
	     		format.js
	     	end
		else
      		redirect_to book_path(@book)
	    end
	end

  private

  def comment_params
		params.require(:book_comment).permit(:comment)
  end

end
