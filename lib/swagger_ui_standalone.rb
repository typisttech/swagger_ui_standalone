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

  def self.download_source(output_directory, repo: SOURCE_REPO, ref: nil, content_directory: "dist")
    url = ref.nil? ? latest_release_archive_link(repo) : archive_link(repo, ref)
    zipball = download url
    extract zipball, content_directory:, destination_directory: output_directory
  end
end
