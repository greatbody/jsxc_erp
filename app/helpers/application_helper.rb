# encoding: UTF-8
module ApplicationHelper
  def all_ethnicity
    [
      ['汉族', '汉族'],
      ['阿昌族', '阿昌族'],
      ['白族', '白族'],
      ['保安族', '保安族'],
      ['布朗族', '布朗族'],
      ['布依族', '布依族'],
      ['朝鲜族', '朝鲜族'],
      ['达斡尔族', '达斡尔族'],
      ['傣族', '傣族'],
      ['德昂族', '德昂族'],
      ['侗族', '侗族'],
      ['东乡族', '东乡族'],
      ['独龙族', '独龙族'],
      ['鄂伦春族', '鄂伦春族'],
      ['俄罗斯族', '俄罗斯族'],
      ['鄂温克族', '鄂温克族'],
      ['高山族', '高山族'],
      ['仡佬族', '仡佬族'],
      ['哈尼族', '哈尼族'],
      ['哈萨克族', '哈萨克族'],
      ['赫哲族', '赫哲族'],
      ['回族', '回族'],
      ['基诺族', '基诺族'],
      ['京族', '京族'],
      ['景颇族', '景颇族'],
      ['柯尔克孜族', '柯尔克孜族'],
      ['拉祜族', '拉祜族'],
      ['黎族', '黎族'],
      ['傈僳族', '傈僳族'],
      ['珞巴族', '珞巴族'],
      ['满族', '满族'],
      ['毛南族', '毛南族'],
      ['门巴族', '门巴族'],
      ['蒙古族', '蒙古族'],
      ['苗族', '苗族'],
      ['仫佬族', '仫佬族'],
      ['纳西族', '纳西族'],
      ['怒族', '怒族'],
      ['普米族', '普米族'],
      ['羌族', '羌族'],
      ['撒拉族', '撒拉族'],
      ['畲族', '畲族'],
      ['水族', '水族'],
      ['塔吉克族', '塔吉克族'],
      ['塔塔尔族', '塔塔尔族'],
      ['土族', '土族'],
      ['土家族', '土家族'],
      ['佤族', '佤族'],
      ['维吾尔族', '维吾尔族'],
      ['乌兹别克族', '乌兹别克族'],
      ['锡伯族', '锡伯族'],
      ['瑶族', '瑶族'],
      ['彝族', '彝族'],
      ['裕固族', '裕固族'],
      ['藏族', '藏族'],
      ['壮族', '壮族']
    ]
  end

  def safe_show(value, attr_name, nil_word = '')
    nil_word = '' if nil_word.nil?
    if value.nil?
      nil_word
    else
      eval('value.' + attr_name)
    end
  end
end
