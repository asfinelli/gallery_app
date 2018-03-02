class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy


  has_attached_file :image,
  if: :is_image_type?, styles: { medium: "500x500>", large: "1000x1000", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
  if: :is_video_type?, styles: {
    large: { geometry: "1000x1000", format: 'flv' },
    medium: { geometry:  "500x500", format: 'flv' },
    thumb: { geometry: "100x100#", format: 'jpg', time: 10 }
  }, processors: [:transcoder]

  validates_attachment_content_type :image, content_type: ['image/png', 'image/jpeg', 'image/jpg', 'image/gif', "video/mp4", "video/m4v", "video/mpeg"]

  def is_image_type?
     content_type = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
     # /\Aimage\/.*\Z/
   end

   def is_video_type?
  content_type = ["video/mp4", "video/m4v", "video/mpeg"]
end




  def previous_post
    self.class.where("created_at > ?", created_at).order(created_at: :asc).first
  end
  def next_post
    self.class.where("created_at < ?", created_at).order(created_at: :desc).first
  end



end
