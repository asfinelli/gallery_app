class Post < ApplicationRecord
  belongs_to :user
  has_many :comments


  has_attached_file :image, styles: { medium: "500x500>", large: "1000x1000", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def previous_post
    self.class.where("created_at > ?", created_at).order(created_at: :asc).first
  end
  def next_post
    self.class.where("created_at < ?", created_at).order(created_at: :desc).first
  end



end
