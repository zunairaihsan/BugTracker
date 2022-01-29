class User < ApplicationRecord
  has_many :enrollments
  has_many :project_enrollment , through: :enrollments ,source: :project 

  validates :role, presence: true
  enum role: [:Manager, :Developer, :Quality]
  has_many :projects , foreign_key: :creator_id, dependent: :destroy
  has_many :bugs ,foreign_key: :creator_id, through: :projects
  has_many :comments ,foreign_key: :creator_id,through: :bugs
  def name_with_type
    "#{full_name} - #{role}"
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 
end
