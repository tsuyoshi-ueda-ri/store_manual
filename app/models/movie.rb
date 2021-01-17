class Movie < ApplicationRecord
  has_one_attached :movie
  # :moveはファイルの呼び名 Active Storageは裏側でBlobとAttachmentモデルを使ってMovie.movieを使えるようにしてくれる。
  has_many :comments, foreign_key: :movie_id, dependent: :destroy
  validates :movie,:title, presence: true
  belongs_to :user, optional: true

  def self.search(search)
    if search != ""
      Movie.where('title LIKE(?)', "%#{search}%")
    else
      Movie.all
    end
  end
end
