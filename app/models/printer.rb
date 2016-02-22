class Printer < ApplicationRecord
  has_one :hub_printer
  has_one :hub, through: :hub_printer
  has_many :jobs, through: :printer_jobs
end
