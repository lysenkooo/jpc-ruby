module JPC
  module Errors
    class UnauthorizedError < RuntimeError
      def message
        'Unauthorized Request'
      end
    end
  end
end
