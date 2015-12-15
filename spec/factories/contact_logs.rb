# encoding: UTF-8
FactoryGirl.define do
  factory :contact_log do
    contact_log 'MyText'
    contact_type 1
    current_status 1
    need_contact 1
    next_contact_at '2015-12-03'
    student nil
  end

end
