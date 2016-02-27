FactoryGirl.define do
  factory :work_task_step do
    work_task nil
operation 1
operate_user_id 1
target_user_id 1
remarks "MyString"
html "MyText"
new_deadline "2016-02-27"
  end

end
