class SourceContract < ActiveRecord::Base
  resourcify

  belongs_to :student_source
end
