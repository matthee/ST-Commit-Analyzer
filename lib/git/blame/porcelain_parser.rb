require_relative "result"
require_relative "line"

module Git
  module Blame

    class PorcelainParser

      def parse!(blame_res)
        commits = Hash.new { |h,k| h[k] = Commit.new(k) }
        authors = Hash.new { |h,k| h[k] = Author.new(k) }

        lines = []

        current_line = nil
        new_commit = true
        blame_res.lines.each do |l|
          if new_commit
            sha, orig_line, line = parse_new_commit_line(l)

            current_line = Line.new
            current_line.original_line_number = orig_line
            current_line.line_number = line
            current_line.commit = commits[sha]

            new_commit = false
            lines << current_line
          else
            if l =~ /^\t/
              current_line.contents = l.sub(/^\t/, "")
              new_commit = true
            else
              header, contents = parse_header_line(l)

              contents.strip!
              case header
              when "summary" then current_line.commit.title = contents
              when "author"
                current_line.commit.author = authors[contents]
              when "author-mail" then current_line.commit.author.email = contents[1..-2]
              end
            end
          end
        end

        Result.new(lines, commits.values, authors.values)
      end

      private
      def parse_new_commit_line(line)
        line.split(/\s/, 3).map.with_index do |part, idx|
          if idx == 0
            part
          else
            part.to_i
          end
        end
      end

      def parse_header_line(line)
        line.split(/\s/, 2)
      end
    end

  end
end