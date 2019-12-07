# frozen_string_literal: true

module Merah
  module Java
    module Util
      def class_name
        arr = self.class.to_s.split("::").map(&:downcase)
        arr.shift
        arr.join("/")
      end
    end
  end
end
