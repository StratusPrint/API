class Alert < ApplicationRecord
  enumerize :type, in: [:hub, :printer, :job, :sensor]

  serialize :sensors, JSON
end
