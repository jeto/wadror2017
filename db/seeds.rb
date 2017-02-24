# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"Lager", description:"Lager (German: storeroom or warehouse) is a type of beer that is conditioned at low temperatures, normally at the brewery. It may be pale, golden, amber, or dark."
s2 = Style.create name:"Pale Ale", description:"Pale ale is an ale made with predominantly pale malt. The higher proportion of pale malts results in a lighter color. The term \"pale ale\" first appeared around 1703 for beers made from malts dried with coke, which resulted in a lighter color than other beers popular at that time. Different brewing practices and hop levels have resulted in a range of taste and strength within the pale ale family"
s3 = Style.create name:"Weizen", description:"Wheat beer is a beer, usually top-fermented, which is brewed with a large proportion of wheat relative to the amount of malted barley. The two main varieties are Weissbier and Witbier; minor types include Lambic, Berliner Weisse and Gose."
s4 = Style.create name:"Porter", description:"Porter is a dark style of beer developed in London from well-hopped beers made from brown malt. The name was first recorded in the 18th century, and is thought to come from its popularity with street and river porters."

b1.beers.create name:"Iso 3", style_id:s1.id
b1.beers.create name:"Karhu", style_id:s1.id
b1.beers.create name:"Tuplahumala", style_id:s1.id
b2.beers.create name:"Huvila Pale Ale", style_id:s2.id
b2.beers.create name:"X Porter", style_id:s4.id
b3.beers.create name:"Hefeweizen", style_id:s3.id
b3.beers.create name:"Helles", style_id:s1.id
