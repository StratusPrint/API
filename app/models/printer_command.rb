class PrinterCommand < ApplicationRecord
  belongs_to :printer
  belongs_to :command
end
