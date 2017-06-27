module Git

  class Author
    attr_accessor :name, :email, :commits

    def initialize(name)
      @name = name
      @commits = []
    end

    def lines
      @commits.flat_map(&:lines)
    end
  end

end
