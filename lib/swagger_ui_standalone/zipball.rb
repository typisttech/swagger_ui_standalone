# frozen_string_literal: true

require "zip"

module SwaggerUIStandalone
  module Zipball
    def extract(path, pattern:, destination_directory:)
      Zip::File.open(path) do |zip_file|
        zip_file.glob(pattern).each do |entry|
          # Remove the leading directory from the entry name
          # e.g. "swagger-api-swagger-ui-3c4e5b7/dist/index.html" --> "dist/index.html"
          i = entry.name.index("/") + 1
          entry_path = entry.name[i..]

          full_destination_path = File.join(destination_directory, entry_path)
          FileUtils.mkdir_p(File.dirname(full_destination_path))

          entry.extract_v3(entry_path, destination_directory:)
        end
      end
    end
  end
end
