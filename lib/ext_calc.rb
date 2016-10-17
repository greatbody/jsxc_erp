# encoding: UTF-8
module ExtCalc
  def self.age_from_idcard(idcard)
    if /\A\d{17}(\d|(x|X))\z/.match(idcard)
      ((Date.today - idcard[6..13].to_date).to_i / 365.0).round(2).to_s
    else
      "-"
    end
  end
end
