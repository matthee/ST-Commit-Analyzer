module Git
  class BlameResult
    attr_reader :lines, :commits, :authors

    def initialize(lines, commits, authors)
      @lines = lines
      @commits = commits
      @authors = authors
    end
  end
end