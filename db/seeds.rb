user_ids = User.pluck(:id)
animal_ids = Animal.pluck(:id)


user_ids.each do |user_id|
  animal_selected_ids = animal_ids.sample(rand(1..3))

  animal_selected_ids.each do |animal_id|
    Submission.create(user_id: user_id, animal_id: animal_id, status: "pending", purpose: "adoption")
  end
end