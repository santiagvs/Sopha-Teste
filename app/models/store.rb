class Store < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates_presence_of :user_id
end
