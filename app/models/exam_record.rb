class ExamRecord < ActiveRecord::Base
  enum kemu: [:km0, :km1, :km2, :km3, :km4]
  enum status: [:wait, :booked, :failed, :passed]
  enum ks_cc: [:morning, :afternoon]

  belongs_to :student

  def ks_cc_text
    I18n.t("exam_record.ks_cc.#{ks_cc}") if ks_cc.present?
    ''
  end

  def status_text
    I18n.t("exam_record.status.#{status}") if status.present?
    ''
  end

  def begin_match_at_str
    if begin_match_at.nil?
      ''
    else
      begin_match_at.date_str
    end
  end

  def end_match_at_str
    if end_match_at.nil?
      ''
    else
      end_match_at.date_str
    end
  end

  def self.status_for_select
    statuses.map do |status, _|
      [I18n.t("exam_record.status.#{status}"), status]
    end
  end

  def self.ks_cc_for_select
    data = [] << ['-','']
    ks_ccs.map do |ks_cc, _|
      data << [I18n.t("exam_record.ks_cc.#{ks_cc}"), ks_cc]
    end
    data
  end

end
