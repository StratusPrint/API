class PrinterJob < ApplicationRecord
  belongs_to :printer
  belongs_to :job
end
