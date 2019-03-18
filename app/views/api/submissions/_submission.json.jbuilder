json.id submission.id
json.user_id submission.user_id
json.animal_id submission.animal_id
json.animal_type submission.animal_type
json.purpose submission.purpose
json.status submission.status
json.relinquish_reason submission.relinquish_reason

json.user do
  json.partial! submission.user, partial: 'api/users/user', as: :user
end

if submission.animal_id
  json.animal do
    json.partial! submission.animal, partial: 'api/animals/animal', as: :animal
  end
end

json.formatted do
  json.purpose submission.purpose.titleize
end


