class Job < ApplicationRecord
  validates :url, presence: true
  validates :employer_name, presence: true
  validates :job_title, presence: true
  validates :job_description, presence: true
  validates :years_of_experience, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :base_salary, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :employment_type_id, numericality: { only_integer: true, greater_than: 0 }

end
