require 'rails_helper'

RSpec.describe School, type: :model do
  it 'is valid with normal name,province,city,district' do
    school = School.new(
      name: '武汉理工大学',
      province: '湖北省',
      city: '武汉市',
      district: '洪山区'
    )
    expect(school).to be_valid
  end

end
