class Movie < ApplicationRecord
  has_one_attached :movie
  # :moveはファイルの呼び名 Active Storageは裏側でBlobとAttachmentモデルを使ってMovie.movieを使えるようにしてくれる。
  has_many :comments
end
