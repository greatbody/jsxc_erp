module BrowserExt
  def is_phone(bros)
    ua = bros.platform.ua[:ua].downcase
    if ua.index('mobile')
      true
    else
      false
    end
  end
end
