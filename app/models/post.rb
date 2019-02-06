class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :song, optional: true
  has_many_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  has_one_attached :image4
  has_one_attached :avatar
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :context, presence: true unless :song_id
  validates :image1, presence: false
  has_many :likes
  has_many :image1
  # has_many :songs
  has_many :comments, dependent: :destroy
  # has_many :songs, inverse_of: :post, dependent: :destroy
  #  accepts_nested_attributes_for :songs, reject_if: proc { |attributes| attributes[:name].blank?}, allow_destroy: true


  def post_type
    if post_id? && context?
      "repost"
    elsif post_id?
      "repost"
    elsif song_id?
       "song"
    else
       "post"
    end
  end


end
