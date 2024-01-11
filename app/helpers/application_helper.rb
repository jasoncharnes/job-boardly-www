module ApplicationHelper
  def login_path
    "https://app.jobboardly.com/sessions/new"
  end

  def registration_path(plan: nil, interval: nil)
    if plan.present? && interval.present?
      "https://app.jobboardly.com/registration/new?plan=#{plan}&interval=#{interval}"
    else
      "https://app.jobboardly.com/registration/new"
    end
  end
end
