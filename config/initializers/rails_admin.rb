# Rails 4.1+ enum support, see https://github.com/sferik/rails_admin/issues/1993
module ActiveRecord
  module RailsAdminEnum
    def enum(definitions)
      super

      definitions.each do |name, values|
        define_method("#{ name }_enum") { self.class.send(name.to_s.pluralize).to_a }

        define_method("#{ name }=") do |value|
          if value.kind_of?(String) and value.to_i.to_s == value
            super value.to_i
          else
            super value
          end
        end
      end
    end
  end
end

RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
end

ActiveRecord::Base.send(:extend, ActiveRecord::RailsAdminEnum)
