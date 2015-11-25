#!/usr/bin/env ruby

require 'kindle_highlights'

class Export < Thor

  desc "export", "Export a list of your Kindle books."
  def export
    books = kindle.books

    data = ""
    data << "asin_id,title\n"

    books.each do |id,title|
      data << "#{id},\"#{title}\"\n"
    end

    File.open("books.csv", "w") { |file| file.write(data) }
  end

  no_tasks do
    def credentials
      creds = YAML.load(File.read(File.expand_path("~/.kindle")))
    end

    def kindle
      KindleHighlights::Client.new("#{credentials["username"]}", "#{credentials["password"]}")
    end
  end

end

Export.start
