class Movie < ApplicationRecord
  has_one_attached :movie
  # Active Storageは裏側でBlobとAttachmentモデルを使ってMovie.movieを使えるようにしてくれる。
  has_many :comments, foreign_key: :movie_id, dependent: :destroy
  validates :movie,:title, presence: true
  belongs_to :user, optional: true
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  accepts_nested_attributes_for :tags


  def self.search(search)
    if search != ""
      # Movie.where(['title LIKE(?) OR content LIKE ?' , "%#{search}%", "%#{search}%"])
      Movie.left_outer_joins(:tags).where(["movies.title LIKE(?) OR tags.tag_name LIKE(?)", "%#{search}%", "%#{search}%"])
    else
      Movie.all
    end
  end

  def save_movies(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create
    new_tags.each do |new_name|
      movie_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << movie_tag
    end
  end
end
