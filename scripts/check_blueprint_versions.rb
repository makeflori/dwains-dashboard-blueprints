#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "open3"
require "rubygems"
require "yaml"

ROOT = File.expand_path("..", __dir__)
BASE_REF = ARGV.fetch(0) do
  warn "Usage: ruby scripts/check_blueprint_versions.rb <base-ref-or-sha>"
  exit 2
end

def load_yaml_text(text)
  if YAML.respond_to?(:safe_load)
    YAML.safe_load(text, permitted_classes: [Date, Time], aliases: true)
  else
    YAML.load(text)
  end
rescue ArgumentError
  YAML.load(text)
end

def blueprint_meta_from_text(text)
  # Ignore README files and images; some legacy blueprint files have no extension.
  return nil unless text.b.match?(/^blueprint:[ \t]*\r?$/n)

  doc = load_yaml_text(text)
  return nil unless doc.is_a?(Hash) && doc["blueprint"].is_a?(Hash) && doc.key?("card")

  doc["blueprint"]
end

def blueprint_meta_from_file(path)
  return nil unless File.file?(path)

  blueprint_meta_from_text(File.read(path))
rescue Psych::SyntaxError => e
  raise "Invalid YAML in #{path}: #{e.message}"
end

def git(*args)
  stdout, stderr, status = Open3.capture3("git", *args, chdir: ROOT)
  raise "git #{args.join(' ')} failed: #{stderr.strip}" unless status.success?

  stdout
end

def file_at(ref, path)
  git("show", "#{ref}:#{path}")
rescue StandardError
  nil
end

def version(meta)
  value = meta && meta["version"]
  return nil if value.nil?

  text = value.to_s.strip
  text.empty? ? nil : text
end

def parse_version(value, path)
  Gem::Version.new(value)
rescue ArgumentError
  raise "#{path}: version '#{value}' is not a valid numeric version"
end

def changed_blueprint_files
  diff = git("diff", "--name-status", "-M", "--diff-filter=AMR", "#{BASE_REF}...HEAD", "--", "page-blueprints", "card-blueprints")
  diff.lines.map do |line|
    parts = line.chomp.split("\t")
    status = parts[0]
    next if status.nil?

    if status.start_with?("R")
      old_path = parts[1]
      new_path = parts[2]
    else
      old_path = parts[1]
      new_path = parts[1]
    end
    next unless new_path

    [status, old_path, new_path]
  end.compact
end

failures = []

changed_blueprint_files.each do |status, old_path, new_path|
  new_full_path = File.join(ROOT, new_path)
  begin
    new_meta = blueprint_meta_from_file(new_full_path)
  rescue StandardError => e
    failures << e.message
    next
  end
  next unless new_meta

  new_version = version(new_meta)
  if new_version.nil?
    failures << "#{new_path}: blueprint.version is required"
    next
  end

  if status == "A"
    begin
      parse_version(new_version, new_path)
    rescue StandardError => e
      failures << e.message
    end
    next
  end

  old_text = file_at(BASE_REF, old_path)
  next if old_text && old_text == File.read(new_full_path)

  old_meta = old_text ? blueprint_meta_from_text(old_text) : nil
  old_version = version(old_meta)
  if old_version.nil?
    failures << "#{new_path}: previous blueprint.version is missing, set a higher numeric version"
    next
  end

  begin
    old_parsed = parse_version(old_version, old_path)
    new_parsed = parse_version(new_version, new_path)
    unless new_parsed > old_parsed
      failures << "#{new_path}: version must increase (#{old_version} -> #{new_version})"
    end
  rescue StandardError => e
    failures << e.message
  end
end

if failures.empty?
  puts "Blueprint version check passed"
else
  warn "Blueprint version check failed:"
  failures.each { |failure| warn "- #{failure}" }
  exit 1
end
