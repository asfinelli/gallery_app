class Post < ApplicationRecord
  belongs_to :user, optional: true

  has_attached_file :image, styles: { medium: "500x500>", large: "1000x1000", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end