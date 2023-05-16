class Todo < ApplicationRecord
  # 1 Todo bisa punya banyak items
  has_many :items, dependent: :destroy

  # Validating presence
  validates_presence_of :title, :created_by  
end
