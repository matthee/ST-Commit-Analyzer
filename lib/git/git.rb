require_relative "commit"
require_relative "author"

module Git

  class Git
    def blame(path)
      result = git_cmd("blame", %w(-p), path)

      blame_porcelain_parser.parse!(result)
    end

    private
    def git_cmd(name, options = [], file = "")
      `git #{name} #{options.join(" ")} -- #{file}`
    end

    def blame_porcelain_parser
      require_relative "blame/porcelain_parser"

      @blame_porcelain_parser ||= Blame::PorcelainParser.new
    end
  end

end
