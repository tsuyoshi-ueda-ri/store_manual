class Movie < ApplicationRecord
  has_one_attached :movie
  # Active Storageは裏側でBlobとAttachmentモデルを使ってMovie.movieを使えるようにしてくれる。
  has_many :comments, foreign_key: :movie_id, dependent: :destroy
  validates :movie,:title, presence: true
  belongs_to :user, optional: true
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps


  def self.search(search)
    if search != ""
      Movie.where('title LIKE(?)', "%#{search}%")
    else
      Movie.all
    end
  end
end
