class Comment < ApplicationRecord
  belongs_to :movie
  validates :content, presence: true
end
