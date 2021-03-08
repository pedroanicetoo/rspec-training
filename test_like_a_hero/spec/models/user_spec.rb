require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user_not_valid) { build(:user, level: FFaker::Random.rand(100..9999)) }
  let(:user) { build(:user) }

  it "is invalid if the level is not between 1 and 99" do
    expect(user_not_valid).to_not be_valid
  end

  it "returns the correct hero title" do
    expect(user.title).to eq("#{user.kind} #{user.nickname} ##{user.level}")
  end

end
