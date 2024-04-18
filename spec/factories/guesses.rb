FactoryBot.define do
  factory :guess do
    coord_x { Random.rand(0..10_000) }
    coord_y { Random.rand(0..10_000) }
    distance { nil }
    is_successful { false }
    match
    user
  end
end
