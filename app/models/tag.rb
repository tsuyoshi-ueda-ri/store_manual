class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :movies, through: :tagmaps

  def self.search(search)
    if search != ""
      Tag.where('tag_name LIKE(?)', "%#{search}%",)
    else
      Tag.all
    end
  end
end