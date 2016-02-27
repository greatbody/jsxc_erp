class WorkTaskStep < ActiveRecord::Base
  belongs_to :work_task

  enum operation: [:close_task, :create_task, :finish_task, :transfer_task]

  def operate_user
    if User.where(id: operate_user_id).count > 0
      User.find(operate_user_id)
    else
      nil
    end
  end

  def target_user
    if User.where(id: target_user_id).count > 0
      User.find(target_user_id)
    else
      nil
    end
  end
end
