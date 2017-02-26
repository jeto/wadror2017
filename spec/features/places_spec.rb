require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(WeatherService).to receive(:weather_for).with("kumpula").and_return(
      nil
    )

    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1, city:"kumpula" ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, all are shown at the page" do
    allow(WeatherService).to receive(:weather_for).with("helsinki").and_return(
      nil
    )
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [ Place.new( name:"Kaisla", id: 1, city:"helsinki" ), 
        Place.new( name:"BrewDog", id: 2, city:"helsinki")]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"
    expect(page).to have_content "Kaisla"
    expect(page).to have_content "BrewDog"
  end

  it "if none are returned by the API, show correct notification" do
    allow(WeatherService).to receive(:weather_for).with("lande").and_return(
      nil
    )
    allow(BeermappingApi).to receive(:places_in).with("lande").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'lande')
    click_button "Search"
    expect(page).to have_content "No locations in lande"
  end
    
end