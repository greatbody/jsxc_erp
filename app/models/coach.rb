class Coach < ActiveRecord::Base
  enum gender: [:female, :male]

  has_many :students

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :id_card_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :coaching_license_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :driving_license_pic, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'

  validates_attachment :avatar, :id_card_pic, :coaching_license_pic, :driving_license_pic, content_type: { content_type: /\Aimage\/.*\Z/, message: '图片格式不正确.' }, size: { less_than: 3.megabytes, message: '图片大小不能超过3Mb.' }
  validates :phone, uniqueness: { message: '手机号码重复.' }, presence: { message: '请输入手机号码.'}, format: { with: /\A1\d{10}\z/, message: '手机号码格式不正确.' }
  validates :id_card, format: { with: /\A\d{17}(\d|(x|X))\z/, message: '身份证号码格式不正确.' }, allow_blank: true, on: :update

  def join_pic_errors
    ['avatar', 'id_card_pic', 'driving_license_pic', 'coaching_license_pic'].each do |pic|
      errors.messages[pic.to_sym] = errors.messages["#{pic}_content_type".to_sym] if errors.messages.has_key?("#{pic}_content_type".to_sym)
    end
  end
end
