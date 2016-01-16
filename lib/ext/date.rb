class Date
  def next_birthday
    if self.month == 2 && self.day == 29
      this_birthday = Date.new(Date.today.year, 2, 28)
    else
      this_birthday = Date.new(Date.today.year, self.month, self.day)
    end
    this_birthday += 1.year if Date.today > this_birthday
    this_birthday
  end

  def days_before_birthday
    (next_birthday - Date.today).to_i
  end
end
