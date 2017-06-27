require "set"

module BlameAnalyzer

  class Author
    attr_accessor :name, :abbreviation, :solitary_loc, :paired_loc, :owned_loc, :created_commits, :participated_commits

    def initialize(name: nil, email: nil, abbreviation: nil)
      @name = name
      @email = email
      @abbreviation = abbreviation
      @solitary_loc = 0
      @paired_loc = 0
      @owned_loc = 0
      @created_commits = Set.new
      @participated_commits = Set.new
    end

    def loc
      @solitary_loc + @paired_loc
    end

    def name
      @name || "Unknown name"
    end
  end

end
