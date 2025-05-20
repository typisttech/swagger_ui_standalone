# frozen_string_literal: true

require_relative "swagger_ui_standalone/github"
require_relative "swagger_ui_standalone/http"
require_relative "swagger_ui_standalone/version"
require_relative "swagger_ui_standalone/zipball"

module SwaggerUIStandalone
  extend GitHub
  extend HTTP
  extend Zipball

  SOURCE_REPO = "swagger-api/swagger-ui"
  DIST_DIR = "dist"

  def self.download_source(output_directory, repo: SOURCE_REPO, ref: nil, pattern: "*/#{DIST_DIR}/**")
    url = ref.nil? ? latest_release_archive_link(repo) : archive_link(repo, ref)
    zipball = download url
    extract zipball, pattern:, destination_directory: output_directory
  end
end
