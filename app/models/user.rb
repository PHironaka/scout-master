class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  extend FriendlyId
  friendly_id :name, use: :slugged
  before_create :confirmation_token
  has_secure_password
  acts_as_voter


  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true



  has_many :comments, dependent: :destroy
  has_many :locations
  has_attached_file :avatar,
                    styles: { large: "600x600", medium: "300x300#", thumb: "50x50#" },
                    storage: :s3,
                    url: ":s3_domain_url",
                    default_url: "oakley.jpg",
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

  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end



  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

    private
      def confirmation_token
          if self.confirm_token.blank?
              self.confirm_token = SecureRandom.urlsafe_base64.to_s
          end
      end


end
