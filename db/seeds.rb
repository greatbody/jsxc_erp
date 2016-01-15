# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
%w(安康驾校 奥通驾校 宝通驾校 博格驾校 常青驾校 晨光驾校 楚成驾校 大学生驾校 大众驾校 东方驾校 方胜驾校 港口驾校 公交驾校 国兴驾校 海峰驾校 恒轩驾校 弘毅驾校 宏达驾校 宏基驾校 宏业驾校 鸿欣驾校 华康驾校 黄陂驾校 黄浦驾校 建安驾校 江城明珠 交发驾校 金凯驾校 金星驾校 谨训驾校 锦光驾校 九泰驾校 兰基驾校 兰剑驾校 蓝盾驾校 蓝星驾校 利成驾校 路正驾校 明安驾校 明华驾校 明涛驾校 南湖驾校 汽大驾校 人和驾校 三环驾校 三山驾校 三侠驾校 绅宝驾校 神威驾校 胜赢驾校 省警官学校 省汽运驾校 顺捷驾校 天罡泰驾校 天马驾校 天天驾校 天意驾校 天宇晨阳驾校 万通驾校 为民驾校 武钢交运驾校 物资驾校 新形驾校 鑫盛驾校 信达驾校 亚太驾校 永安驾校 永信驾校 又一春驾校 育才驾校 远通驾校 邾城驾校).each do |school_name|
  TrainSchool.create(name: school_name)
end
