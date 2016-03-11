module Errors
  class UnauthorizedAccessError
    def self.message
      'You do not have permission to access this resource.'
    end

    def self.to_hash
      {
        error: message
      }
    end

    def self.to_json(*)
      to_hash.to_json
    end
  end
end
