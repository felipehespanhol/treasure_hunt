json.winners @winners do |winner|
  json.(winner, :id, :email, :best_distance)
end
