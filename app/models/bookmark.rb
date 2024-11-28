class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie, uniqueness: { scope: :list }
  validates :movie, :list, presence: true
  validates :comment, length: { minimum: 6 }
end
