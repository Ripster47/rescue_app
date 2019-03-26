json.id animal.id
json.name animal.name
json.species animal.species
json.description animal.description
json.adoptable animal.adoptable
json.medical_status animal.medical_status
json.gender animal.gender
json.age animal.age
json.image_url animal.image_url
json.donation animal.donation

json.formatted  do 
  json.donation number_to_currency(animal.donation, precision: 2)
end