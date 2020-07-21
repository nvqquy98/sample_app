class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  scope :sort_create_at, ->{order("created_at desc")}
  scope :feed_list, ->(following_ids, id){where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)}
  # Ex:- scope :active, -> {where(:active => true)}
  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost.content.max_length}
  validates :image,
            content_type: {in: %w(image/jpeg image/gif image/png),
                           message: "must be a valid image format"},
            size:
            {less_than: 5.megabytes,
             message: "should be less than 5MB"}
  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
