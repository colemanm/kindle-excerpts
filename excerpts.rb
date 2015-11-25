#!/usr/bin/env ruby

require 'kindle_highlights'
require 'thor'
require 'json'

class Highlights < Thor

  desc "excerpt", "Extract Kindle excerpts for a specified title."
  method_option :asin, aliases: "-a", desc: "ASIN number for Amazon title.", required: true
  method_option :file, aliases: "-f", desc: "Name of output file."
  method_option :json, aliases: "-j", desc: "Generate json output.", type: :boolean, default: false
  method_option :md, aliases: "-m", desc: "Generate markdown output.", type: :boolean, default: false
  def excerpt
    highlights = kindle.highlights_for("#{options[:asin]}")
    puts JSON.pretty_generate(JSON.parse(highlights.to_json))

    if options[:json]
      File.open("#{options[:file]}.json", 'w') do |file|
        file << JSON.pretty_generate(JSON.parse(highlights.to_json))
      end
    end

    if options[:md]
      data = ""
      highlights.each do |h|
        data << "#{h["highlight"]}\n\n"
      end

      File.open("#{options[:file]}.md", 'w') do |file|
        file << data
      end
    end
  end
  default_task :excerpt

  no_tasks do
    def credentials
      creds = YAML.load(File.read(File.expand_path("~/.kindle")))
    end

    def sluggify(text)
      text.split(/\W/).delete_if(&:blank?).join('-').downcase.gsub(/_/, '-')
    end

    def kindle
      KindleHighlights::Client.new("#{credentials["username"]}", "#{credentials["password"]}")
    end
  end
end

Highlights.start
