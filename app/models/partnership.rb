class Partnership < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: "User"

  validates :user, uniqueness: { scope: :partner }
end
