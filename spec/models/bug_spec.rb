require 'rails_helper'

RSpec.describe Bug, type: :model do

  context 'validations' do
    it 'is not valid without bugtype' do
      bug = Bug.new(bugtype:nil)
      expect(bug).to_not be_valid
    end
    it 'is not valid without title' do
      bug = Bug.new(title:nil)
      expect(bug).to_not be_valid
    end
    it 'is not valid without description' do
      bug = Bug.new(description:nil)
      expect(bug).to_not be_valid
    end
    it 'is not valid without deadline' do
      bug = Bug.new(deadline:nil)
      expect(bug).to_not be_valid
    end
    it 'is not valid without status' do
      bug = Bug.new(status:nil)
      expect(bug).to_not be_valid
    end
    it 'ensures save successfull' do 
      bug= Bug.new(title: nil ,description: nil , deadline: nil, status: nil ).save
      expect(bug).to eq(false)
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:comments).dependent:destroy }
    it { should belong_to(:project).optional}
    it { should belong_to(:assigned_to).optional }
    it { should belong_to(:created_by) }
    
  end

  it { should have_one_attached(:image) }

  
end
