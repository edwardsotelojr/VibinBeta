class Song < ApplicationRecord
  belongs_to :user
  has_many :posts #, inverse_of: :songs
  validates :title, presence: true, length: {maximum: 40}
  validates :text, length: {maximum: 100}
  validates :genre, presence: true
  has_one_attached :song_file
  validates :song_file, presence: true
  validate :correct_file_type?

  private

  def correct_file_type?
    if song_file.attached? && !song_file.content_type.in?(%w(audio/mp3 audio/mp4 audio/mpeg))
      errors.add(:song_file, 'Must be an AUDIO file!')
    end
  end
end
