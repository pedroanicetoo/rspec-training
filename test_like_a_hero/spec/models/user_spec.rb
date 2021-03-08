require 'rails_helper'

RSpec.describe User, type: :model do
  let(:nickname) { FFaker::Name.first_name }
  let(:kind) { %i[knight wizard].sample }
  let(:level) { FFaker::Random.rand(100..9999) }

  let(:user) { User.create(nickname: nickname, kind: kind, level: level) }

  it "is invalid if the level is not between 1 and 99" do
    expect(user).to_not be_valid
  end

  it "returns the correct hero title" do
    expect(user.title).to eq("#{kind} #{nickname} ##{level}")
  end

end
