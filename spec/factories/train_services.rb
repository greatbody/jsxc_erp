FactoryGirl.define do
  factory :train_service do
    name "[2900]特价班"
    base_price "9.99"
    price "9.99"
    discount_price "9.99"
    sr_health_check false
    sr_km1 false
    sr_km2 false
    sr_km3 false
    sr_km4 false
    sim_km2_price "9.99"
    sim_km3_price "9.99"
    km2_bk_fee "9.99"
    km3_bk_fee "9.99"
  end

end
