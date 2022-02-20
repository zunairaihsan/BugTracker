class Bug < ApplicationRecord

    validate :image_content_type
    validates :title, presence: true
    validates :bugtype, presence: true
    validate :image_content_type
    validates_uniqueness_of :title

    belongs_to :project, :optional => true
    belongs_to :assigned_to, class_name: :User, optional: true
    belongs_to :created_by, class_name: :User
    has_one_attached :image , :dependent => :destroy
    has_many :comments , :dependent => :destroy
   
   
    enum bugtype: %i[Bug Feature]
    enum status: %i[New Started Resolved]
    

   
private

def image_content_type
    if image.attached? && !image.content_type.in?(%w(image/png image/gif) )
        errors.add(:image ,"must be png or gif")
    end
end




end