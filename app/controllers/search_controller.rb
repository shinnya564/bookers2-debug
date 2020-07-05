class SearchController < ApplicationController

	def search
		@book = Book.new
		@user_or_book = params[:model]
		@match = params[:match]

		if @user_or_book == "1"
		   @searchusers = User.search(params[:search], @user_or_book, @match)
		else
		   @searchbooks = Book.search(params[:search], @user_or_book, @match)
		end
    end

end
