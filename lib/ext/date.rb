class Date
  def next_birthday
    today = Date.today
    if self.month == 2 && self.day == 29
      if today.leap?
        this_birthday = Date.new(today.year, 2, 29)
      else
        this_birthday = Date.new(today.year, 3, 1)
      end
    else
      this_birthday = Date.new(today.year, self.month, self.day)
    end
    this_birthday += 1.year if today > this_birthday
    this_birthday
  end

  def days_before_birthday
    (next_birthday - Date.today).to_i
  end

  def date_str
    unless self.nil?
      self.to_s(:db)
    end
  end
end
