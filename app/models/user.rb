class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  attachment :profile_image, destroy: false

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ユーザーをフォローする
def follow(user_id)
  relationships.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  relationships
  .find_by(followed_id: user_id).destroy
end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
