class HubPrinter < ApplicationRecord
  belongs_to :hub
  belongs_to :printer, :dependent => :destroy
end
