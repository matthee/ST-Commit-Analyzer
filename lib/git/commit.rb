module Git

  class Commit
    attr_accessor :sha, :title, :author, :lines

    def initialize(sha)
      @sha = sha
      @lines = []
    end

    def author=(author)
      @author = author
      @author.commits << self
    end
  end

end