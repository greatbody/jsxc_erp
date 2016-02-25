class WorkTask < ActiveRecord::Base
  def from_user
    if User.where(id: from_user_id).count > 0
      User.find(from_user_id)
    else
      nil
    end
  end

  def to_user
    if User.where(id: to_user_id).count > 0
      User.find(to_user_id)
    else
      nil
    end
  end
end
