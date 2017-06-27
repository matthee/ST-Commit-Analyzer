module Git
  module Blame

    class Line
      attr_accessor :commit, :original_line_number, :line_number, :contents

      def author
        commit.author
      end

      def commit=(commit)
        @commit = commit
        @commit.lines << self
      end
    end

  end
end