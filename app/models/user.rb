# encoding: UTF-8
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable
  rolify :before_add => :before_add_method

  validates :phone, uniqueness: { message: '手机号码重复.' }, presence: { message: '请输入手机号码.'}, format: { with: /\A1\d{10}\z/, message: '手机号码格式不正确.' }
  validates :name, presence: { message: '请输入姓名' }
  has_many :students
  has_many :intentions
  has_many :contact_logs
  has_many :student_sources
  has_many :daily_signs

  def before_add_method(role)
    # do something before it gets added
  end
end
