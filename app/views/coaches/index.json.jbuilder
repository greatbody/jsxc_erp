json.array!(@coaches) do |coach|
  json.extract! coach, :id, :phone, :name, :gender, :id_card, :birthday, :wechat, :qq, :coaching_license, :driving_license
  json.url coach_url(coach, format: :json)
end
