class WorkTask < ActiveRecord::Base
  has_many :work_task_steps

  enum task_type: [:other, :activity, :free_try, :request_pay]
  # other 其它
  # activity 活动
  # free_try 免费试学
  # request_pay 催款
  # complaint 投诉
  enum status: [:closed, :active, :done]
  # closed 已关闭（任务未完成，但是不需要执行了）
  # active 激活状态（任务待处理）
  # done 已完成

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

  def status_text
    I18n.t("work_task.status.#{status}")
  end
end
