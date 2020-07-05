class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :book
  has_many :book_comment
  has_many :favorite
  has_many :following_relationships,foreign_key: "follower_id", class_name: "FollowRelationship",  dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id",class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  #すでにフォロー済みであればture返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

  #DBからユーザー名を検索する
  def User.search(search, user_or_book, match)
    if user_or_book == "1"
      if match == "1"
        User.where(['name LIKE ?', "#{search}"])
      elsif match == "2"
        User.where(['name LIKE ?', "#{search}%"])
      elsif match == "3"
        User.where(['name LIKE ?', "%#{search}"])
      elsif match == "4"
        User.where(['name LIKE ?', "%#{search}%"])
      else
        User.all
      end
    end
  end
end
