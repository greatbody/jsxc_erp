class Coach < ActiveRecord::Base
  resourcify

  enum gender: [:female, :male]
  enum coach_type: [:cover_all_training, :cover_all, :just_display]

  has_many :students

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :id_card_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :coaching_license_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :driving_license_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'

  validates_attachment :avatar, :id_card_pic, :coaching_license_pic, :driving_license_pic, content_type: { content_type: /\Aimage\/.*\Z/, message: '图片格式不正确.' }, size: { less_than: 3.megabytes, message: '图片大小不能超过3Mb.' }
  validates :phone, uniqueness: { message: '手机号码重复.' }, presence: { message: '请输入手机号码.'}, format: { with: /\A1\d{10}\z/, message: '手机号码格式不正确.' }
  validates :id_card, format: { with: /\A\d{17}(\d|(x|X))\z/, message: '身份证号码格式不正确.' }, allow_blank: true, on: :update

  def self.coach_for_select
    coach_collection = [['[空]', '']]
    Coach.all.each do |coach|
      coach_collection << [coach.name, coach.id]
    end
    coach_collection
  end

  def gender_text
    return I18n.t("sexs.#{gender}") if gender.present?
    '-'
  end

  def self.gender_for_select
    genders.map do |gender, _|
      [I18n.t("coach.gender.#{gender}"), gender]
    end
  end

end
