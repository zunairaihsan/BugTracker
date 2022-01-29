class Project < ApplicationRecord

    validates :title, presence: true
    belongs_to :creator, class_name: :User
    has_many :enrollments , dependent: :delete_all
    has_many :enrolled_user, through: :enrollments, source: :user
    has_many :bugs, dependent: :destroy
    
end
