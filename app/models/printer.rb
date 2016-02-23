class Printer < ApplicationRecord
  validates :friendly_id, :uniqueness => true

  has_one :hub_printer
  has_one :hub, through: :hub_printer
  has_many :printer_jobs
  has_many :jobs, through: :printer_jobs
end
