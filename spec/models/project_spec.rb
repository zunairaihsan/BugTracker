require 'rails_helper'

RSpec.describe Project, type: :model do

  context 'validations' do
    it "is not valid without a title" do
      project = Project.new(title: nil)
      expect(project).to_not be_valid
    end
    it "is not valid without a desicriprion" do
      project = Project.new(description: nil)
      expect(project).to_not be_valid
    end
    it "is not valid without a creator_id" do
      project = Project.new(creator_id: nil)
      expect(project).to_not be_valid
    end

    it 'ensures save successfull' do 
      project= Project.new(title: nil ,description: nil , creator_id: nil ).save
      expect(project).to eq(false)
    end
  end
  
  context 'associations' do
    it { is_expected.to have_many(:bugs).dependent(:destroy) }
    it { is_expected.to have_many(:enrollments)}
    it { is_expected.to have_many(:enrolled_user).through(:enrollments) }
    it { should belong_to(:creator).class_name:User }
  end

  

end
