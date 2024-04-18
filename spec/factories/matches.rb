FactoryBot.define do
  factory :match do
    treasure_x { Random.rand(0..10_000) }
    treasure_y { Random.rand(0..10_000) }
    closest_distance { nil }
  end
end
