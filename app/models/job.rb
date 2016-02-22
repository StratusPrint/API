class Job < ApplicationRecord
  has_one :printer_job
  has_one :printer, through: :printer_job
end
