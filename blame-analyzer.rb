#!/usr/bin/env ruby

require "ruby-progressbar"
require_relative "lib/blame_analyzer"

if ARGV.length != 1
  puts "Usage: #{$0} path/to/git_repo"
  exit 1
end

project_path = ARGV.first

unless File.exist? project_path
  puts "No such file or directory: #{project_path}"
  exit 2
end

allowed_extensions = %w(.java .xml .gradle)

progressbar = ProgressBar.create(:format => '%a |%b>>%i| %p%% %t', :throttle_rate => 0.1)

analyzer = BlameAnalyzer::Analyzer.new
Dir.chdir(project_path) do
  paths_to_blame = []
  progressbar.total = nil
  progressbar.title = "Reading Dir"
  Dir.glob("**/*").each do |path|
    next unless allowed_extensions.any? { |e| path.end_with?(e) } && !path.include?("build/")
    paths_to_blame << path
    progressbar.increment
  end

  progressbar.reset
  progressbar.start
  progressbar.total = paths_to_blame.length
  progressbar.title = "Analyzing"
  paths_to_blame.each do |path|
    analyzer.analyze_file! path
    progressbar.increment
  end
end

progressbar.finish
progressbar.log ""
progressbar.log analyzer.summary
progressbar.log "File extensions: #{allowed_extensions.join(", ")}"