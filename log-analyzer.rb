#!/usr/bin/env ruby

if ARGV.length != 1
  puts "Usage: #{$0} path/to/git_repo"
  exit 1
end

path = ARGV.first

unless File.exist? path
  puts "No such file or directory: #{path}"
  exit 2
end

log = nil
Dir.chdir(path) do
  log = `git log --oneline upstream/master`
end

users = Hash.new { |h,k| h[k] = 0 }

log.lines.each do |l|
  l.sub!(/^[a-f0-9]+\s/, "")

  matches = l.match(/^\[(?<users>[^\]]+)\]/)

  unless matches.nil?
    users_for_commit = matches[:users].split(",").map(&:strip)

    users_for_commit.each do |u|
      users[u] += 1
    end
  end
end

users.sort_by {|u,c| -c }.each do |user, commit_count|
  puts "#{user}: #{commit_count}"
end