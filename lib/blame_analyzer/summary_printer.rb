module BlameAnalyzer

  class SummaryPrinter
    def initialize(analyzer)
      @analyzer = analyzer
    end

    def generate
      total_loc = @analyzer.loc.to_f / 100

      summary = []
      summary << " Summary (in current version) ".center(150, '=')

      rows = []
      rows << ["", "LOC", "", "", "", "", "", "", "Commits", ""]
      rows << ["", "solitary", "paired", "participation", "participation %", "owned", "owned %", "pairing %", "created", "participated"]
      @analyzer.authors.sort_by(&:loc).reverse.each do |a|
        rows << [
          "#{a.name} (#{a.abbreviation}):",
          "#{a.solitary_loc}",
          "#{a.paired_loc}",
          "#{a.loc}",
          "#{(a.loc / total_loc).round(2)}%",

          "#{a.owned_loc.round(2)}",
          "#{(a.owned_loc / total_loc).round(2)}%",
          "#{(a.paired_loc.to_f * 100 / a.loc).round(2)} %",

          "#{a.created_commits.length}",
          "#{a.participated_commits.length}",
        ]
      end

      col_lengths = rows.inject([]) do |agg, row|
        row.each.with_index { |cell, idx| agg[idx] = [(agg[idx] || 0), cell.length].max }
        agg
      end

      rows.each do |row|
        summary << row.map.with_index { |cell, idx| cell.ljust(col_lengths[idx]) }.join("\t")
      end
      summary << ""
      summary << "Total LOC: #{@analyzer.loc}"
      summary << "Files Analyzed: #{@analyzer.files}"

      summary.join("\n")
    end
  end

end