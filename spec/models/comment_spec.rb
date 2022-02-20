require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:bug) }
  it { should belong_to(:user) }
end
