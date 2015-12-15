# encoding: UTF-8
class Student < ActiveRecord::Base
  enum sex: [:female, :male, :unknown]

  validates :phone, uniqueness: { message: '手机号码重复.' }, presence: { message: '请输入手机号码.'}, format: { with: /\A1\d{10}\z/, message: '手机号码格式不正确.' }
  validates :name, presence: { message: '请输入姓名' }
  validates :id_card, format: { with: /\A\d{17}(\d|(x|X))\z/, message: '身份证号码格式不正确.' }, allow_nil: true, on: :update
  validates :address, length: { maximum: 255, message: '地址超出长度限制' }
  validates :unit, length: { maximum: 255, message: '单位名称超出长度限制' }

  scope :normal, -> { joins(:intention).where(intentions: { current_status: 0 }) }

  belongs_to :user
  has_one :intention
  has_many :contact_logs

  accepts_nested_attributes_for :intention
end
