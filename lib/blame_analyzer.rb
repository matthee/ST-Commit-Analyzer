require_relative "blame_analyzer/author"
require_relative "blame_analyzer/summary_printer"
require_relative "git/git"

module BlameAnalyzer

  class Analyzer
    attr_reader :loc, :files

    def initialize
      @authors = Hash.new { |h,k| h[k] = Author.new(abbreviation: k) }
      @loc = 0
      @files = 0
      @git = Git::Git.new
    end

    def analyze_file!(path)
      blame_result = @git.blame(path)
      blame_result.authors.each do |author|
        abbr = abbreviation_for_author(author)

        a = @authors[abbr]
        a.name = author.name
      end

      blame_result.commits.each do |commit|
        abbr = abbreviation_for_author(commit.author)

        a = @authors[abbr]
        a.created_commits << commit.sha
      end

      blame_result.lines.each do |line|
        git_author = line.commit.author

        authors_for_line = []
        authors_for_line << @authors[abbreviation_for_author(git_author)]
        author_for_abbrs = extract_authors_abbreviations_from_commit(line.commit).map do |abbr|
          @authors[abbr]
        end

        authors_for_line += author_for_abbrs
        authors_for_line.uniq!

        if authors_for_line.length == 1
          authors_for_line.first.solitary_loc += 1
        else
          authors_for_line.each do |author|
            author.paired_loc += 1
          end
        end

        authors_for_line.each do |author|
          author.participated_commits << line.commit.sha
          author.owned_loc += 1.0 / authors_for_line.length
        end
      end

      @loc += blame_result.lines.length
      @files += 1
    end

    def authors
      @authors.values
    end

    def summary
      printer = SummaryPrinter.new(self)
      printer.generate
    end

    private

    def extract_authors_abbreviations_from_commit(commit)
      matches = commit.title.match(/^\[(?<users>[^\]]+)\]/)

      unless matches.nil?
        matches[:users].split(",").map(&:strip)
      else
        []
      end
    end

    def abbreviation_for_author(author)
      author.name.split("\s", 2).map { |part| part[0] }.join.upcase
    end
  end

end