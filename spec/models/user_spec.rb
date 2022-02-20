require 'rails_helper'

RSpec.describe User, type: :model do
    

    context 'validation tests' do 
        it "is not valid without a role" do
            user = User.new(role: nil)
            expect(user).to_not be_valid
          end

        it 'ensures email presence true' do 
            user = User.new(email: nil)
            expect(user).to_not be_valid
        end
        it 'ensures username presence true' do 
            user = User.new(full_name: nil)
            expect(user).to_not be_valid
        end
  
        it { should validate_presence_of :password }
        it { should validate_confirmation_of :password }
        it { should validate_uniqueness_of(:email).case_insensitive }
       

    end


    



    context 'associations' do
        it { is_expected.to have_many(:projects).dependent(:destroy) }
        it { should have_many(:bugs).through(:projects) }
        it { should have_many(:comments).through(:bugs) }
        it { should have_many(:enrollments) }
        it { is_expected.to have_many(:project_enrollment).through(:enrollments) }
    end
   
    context 'save successfully' do
        it 'ensures save successfull' do 
            user= User.new(full_name: nil ,email: nil , role: nil ).save
            expect(user).to eq(false)
        end
    end
end
