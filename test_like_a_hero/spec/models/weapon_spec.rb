require 'rails_helper'

RSpec.describe Weapon, type: :model do

  let(:weapon) { build(:weapon) }
  let(:current_power) {  weapon.power_base + (( weapon.level - 1) * weapon.power_step) }

  it "generates the current_power of weapon" do
    expect(weapon.current_power).to eq(current_power)
  end

  it "generates title of the current_weapon" do
    expect(weapon.title).to eq("#{weapon.name} ##{weapon.level}")
  end

end
