class SourceContact < ActiveRecord::Base
  resourcify

  belongs_to :student_source
end
