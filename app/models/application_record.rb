class ApplicationRecord < ActiveRecord::Base
  include Swagger::Blocks
  extend Enumerize
  self.abstract_class = true
end
