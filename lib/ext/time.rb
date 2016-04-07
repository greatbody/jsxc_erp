class Time
  def date_str
    unless self.nil?
      self.localtime.to_date.to_s(:db)
    end
  end
end
