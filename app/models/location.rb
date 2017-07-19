class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  acts_as_votable
  extend FriendlyId
  friendly_id :title, use: :slugged


  def should_generate_new_friendly_id?
    new_record?
  end


  belongs_to :user
  has_attached_file :image,
                    styles: { large: "", medium: "300x300#", thumb: "100x100#" },
                    storage: :s3,
                    :s3_protocol => :https,
                    url: ":s3_domain_url",
                    default_url: "placeholder.jpg",
                    path: "/:class/:attachment/:id_partition/:style/:filename",
                    s3_region: ENV["S3_REGION"],
                    s3_credentials: Proc.new { |a| a.instance.s3_credentials }




  def s3_credentials
    {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    }
  end



   acts_as_taggable

   def self.search(search)
     if search
       find( :conditions => ['name LIKE ?', "%#{search}%"])

     end
   end

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :comments, dependent: :destroy



end
