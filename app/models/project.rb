class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'primary'
    when 'complete'
      'success'
    end
  end

  def status
    return "not-started" if tasks.none?
     
    if tasks.all? { |task| task.complete? }
      "complete"
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      "in-progress"
    else
      "not-started"
    end
  end 

  def percent_complete
    return 0 if tasks.none?
    @completed_tasks = tasks.select { |task| task.complete? }.count
    ((@completed_tasks.to_f / total_tasks) * 100).round
  end


  def total_complete
   @completed_tasks
  end 

  def total_tasks
    tasks.count
  end

end
