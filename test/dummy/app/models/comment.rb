class Comments < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end
