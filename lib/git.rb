require_relative "git/blame_porcelain_parser"

module BlameAnalyzer
  class Git
    def initialize

    end

    def blame(path)

      cmd = "git blame -p -- #{}"
    end

    def git_cmd(name, options = [], file = "")
      `git #{name} #{options.join(" ")} -- #{file}`
    end

    def blame_porcelain_parser
      @blame_porcelain_parser ||= Git::BlamePorcelainParser
    end
  end
end