#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "date"
require "json"
require "yaml"

OWNER, REPO = ENV.fetch("GITHUB_REPOSITORY", "makeflori/dwains-dashboard-blueprints").split("/", 2)
BRANCH = "main"
BASE_RAW = "https://raw.githubusercontent.com/#{OWNER}/#{REPO}/#{BRANCH}"
ROOT = File.expand_path("..", __dir__)

TYPE_ORDER = {
  "page" => 0,
  "card" => 1,
  "replace-card" => 2,
}.freeze

IMAGE_EXTENSIONS = %w[.png .jpg .jpeg .webp .gif].freeze
IMAGE_HINTS = [
  /preview/i,
  /screenshot.*light/i,
  /screenshot/i,
].freeze

def load_yaml(path)
  text = File.read(path)
  if YAML.respond_to?(:safe_load)
    YAML.safe_load(text, permitted_classes: [Date, Time], aliases: true)
  else
    YAML.load(text)
  end
rescue ArgumentError
  YAML.load(text)
end

def clean(value)
  return nil if value.nil?

  string = value.to_s.strip
  string.empty? ? nil : string
end

def encode_path(path)
  path.split("/").map { |part| CGI.escape(part).gsub("+", "%20") }.join("/")
end

def raw_url(path)
  "#{BASE_RAW}/#{encode_path(path)}"
end

def blueprint_file?(path)
  return false unless File.file?(path)

  File.foreach(path) do |line|
    return true if line.match?(/^blueprint:\s*$/)
  end
  false
rescue ArgumentError, Encoding::InvalidByteSequenceError, Encoding::UndefinedConversionError
  false
end

def image_for(relative_path)
  dir = File.dirname(File.join(ROOT, relative_path))
  candidates = Dir.children(dir).select do |child|
    path = File.join(dir, child)
    File.file?(path) && IMAGE_EXTENSIONS.include?(File.extname(child).downcase)
  end.sort
  return nil if candidates.empty?

  picked = nil
  IMAGE_HINTS.each do |hint|
    picked = candidates.find { |child| child.match?(hint) }
    break if picked
  end
  picked ||= candidates.first

  raw_url(File.join(File.dirname(relative_path), picked))
end

def blueprint_paths
  roots = %w[page-blueprints card-blueprints]
  roots.flat_map do |root|
    Dir.glob(File.join(ROOT, root, "**", "*"), File::FNM_DOTMATCH)
  end.select { |path| blueprint_file?(path) }
    .map { |path| path.delete_prefix("#{ROOT}/") }
    .sort
end

blueprints = blueprint_paths.map do |path|
  doc = load_yaml(File.join(ROOT, path))
  unless doc.is_a?(Hash) && doc["blueprint"].is_a?(Hash) && doc.key?("card")
    warn "Skipping #{path}: missing blueprint/card sections"
    next
  end

  meta = doc.fetch("blueprint")
  custom_cards = Array(meta["custom_cards"]).map { |value| clean(value) }.compact
  type = clean(meta["type"]) || (path.start_with?("page-blueprints/") ? "page" : "card")

  {
    "name" => clean(meta["name"]) || File.basename(path, ".*"),
    "description" => clean(meta["description"]),
    "type" => type,
    "version" => clean(meta["version"]),
    "url" => raw_url(path),
    "image" => image_for(path),
    "custom_cards" => custom_cards.empty? ? nil : custom_cards,
  }.compact
end.compact

blueprints.sort_by! do |entry|
  [TYPE_ORDER.fetch(entry["type"], 99), entry["name"].downcase, entry["url"]]
end

registry = {
  "_comment" => "Registry for Dwains Dashboard v4 blueprint gallery. Entries are generated from blueprint YAML files in this repository; name and url are required by the dashboard.",
  "blueprints" => blueprints,
}

File.write(File.join(ROOT, "blueprints.json"), "#{JSON.pretty_generate(registry)}\n")
puts "Wrote blueprints.json with #{blueprints.length} entries"
