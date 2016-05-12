module Messages
  class CommandIssuedMessage
    def self.status
      204
    end

    def self.message
      'Command sent to printer.'
    end

    def self.to_hash
      {
        message: message
      }
    end

    def self.to_json(*)
      to_hash.to_json
    end
  end
end
