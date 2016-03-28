FactoryGirl.define do
  factory :coach do
    phone "13349928561"
    name "柯奇云"
    gender 1
    id_card "420111198911031204"
    birthday "2015-12-16"
    wechat "疯子"
    qq "66666666"
    coaching_license "lasjflakjsdlfkj"
    driving_license "143401283492378"
    
    factory :coach_with_train_service do
      after(:create) do |coach|
        create(:train_service, coach: coach)
      end
    end
  end

end
