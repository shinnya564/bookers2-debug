class RelationshipsController < ApplicationController

	def create
    	user = Book.find(params[:user_id])
    	book = Book.find(params[:id])
    	relationship = current_user.relationship.new(user_id: user.id)
    	relationship.fllowing_id = book.user_id
    	relationship.save
	    redirect_to request.referer
	end

	def destroy
	    user = Book.find(params[:user_id])
	    relationship = current_user.relationship.find_by(user_id: user.id)
	    relationship.destroy
	    redirect_to request.referer
	end

end
