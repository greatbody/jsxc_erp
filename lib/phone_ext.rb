module PhoneExt
  def self.format_phone(phone)
    return phone if phone.length != 11
    phone[0..2] + ' ' + phone[3..6] + ' ' + phone[7..11]
  end
end
