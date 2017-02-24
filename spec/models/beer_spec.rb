require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is created with name and style" do
    beer = Beer.create name:"Kalja", style: FactoryGirl.create(:style)

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "is not created without name" do
    beer = Beer.create style: FactoryGirl.create(:style)

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created without a style" do
    beer = Beer.create name:"Kalja"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
