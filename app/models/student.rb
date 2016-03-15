# encoding: UTF-8
class Student < ActiveRecord::Base
  enum sex: [:female, :male, :unknown]
  enum process: [:wait, :km1, :km2, :km3, :km4, :lingzheng]
  enum km1_status: [:wait_order, :can_order, :ordered, :passed, :failed, :need_order]

  validates :phone, uniqueness: { message: '手机号码重复.' }, presence: { message: '请输入手机号码.'}, format: { with: /\A1\d{10}\z/, message: '手机号码格式不正确.' }
  validates :name, presence: { message: '请输入姓名' }
  validates :id_card, format: { with: /\A\d{17}(\d|(x|X))\z/, message: '身份证号码格式不正确.' }, allow_blank: true, on: :update
  validates :address, length: { maximum: 255, message: '地址超出长度限制' }
  validates :unit, length: { maximum: 255, message: '单位名称超出长度限制' }

  scope :normal, -> { joins(:intention).where(intentions: { current_status: 0 }) }

  belongs_to :user
  belongs_to :coach
  has_one :intention
  belongs_to :train_service
  has_many :contact_logs
  has_many :residence_cards

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '80x80>' }, default_url: '/80x80.png'
  has_attached_file :id_card_pic, styles: { medium: '500x300>', thumb: '250x150>' }, default_url: '/500x300.png'
  has_attached_file :id_card_back_pic, styles: { medium: '500x300>', thumb: '250x150>' }, default_url: '/500x300.png'

  accepts_nested_attributes_for :intention

  def gender
    return I18n.t("sexs.#{sex}") if sex.present?
    '【未填写】'
  end

  def self.process_for_select
    processes.map do |process, _|
      [I18n.t("student.process.#{process}"), process]
    end
  end

  def self.km1_status_for_select
    km1_statuses.map do |km1_status, _|
      [I18n.t("student.km1_status.#{km1_status}"), Student.km1_statuses[km1_status]]
    end
  end

  def process_text
    I18n.t("student.process.#{process}")
  end

  def self.student_for_select
    student_collection = [['[空]', '']]
    Student.all.each do |student|
      student_collection << [student.name, student.id]
    end
    student_collection
  end

  def self.sex_for_select
    sexes.map do |sex, _|
      [I18n.t("sexs.#{sex}"), sex]
    end
  end
end
