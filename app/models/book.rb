class Book < ApplicationRecord
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	has_many :book_comments
	has_many :favorites

	def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
  	end

	def Book.search(search, user_or_book, match)
	    if user_or_book == "2"
	      if match == "1"
	        Book.where(['title LIKE ?', "%#{search}%"])
	      elsif match == "2"
	        Book.where(['title LIKE ?', "#{search}%"])
	      elsif match == "3"
	        Book.where(['title LIKE ?', "%#{search}"])
	      elsif match == "4"
	        Book.where(['title LIKE ?', "%#{search}%"])
	      else
	        Book.all
	      end
	    end
	end
end
