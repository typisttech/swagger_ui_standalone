# frozen_string_literal: true

require "thor"
require_relative "../swagger_ui_standalone"

module SwaggerUIStandalone
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    def self.define_downloadable_options
      option :output,
        aliases: ["-o", "--out"],
        type: :string,
        desc: "Where to write the generated files",
        banner: "DIRECTORY",
        required: true
      option :repo,
        type: :string,
        banner: "OWNER/REPO",
        desc: "GitHub repository to download in the format <owner/repo>",
        default: SwaggerUIStandalone::SOURCE_REPO
      option :ref,
        type: :string,
        banner: "TAG|BRANCH|SHA",
        desc: "Git reference to download (can be a tag, branch or commit SHA). Omit to use the latest release"
    end

    desc "download [options]", "Download standalone static SwaggerUI source code"
    define_downloadable_options

    def download
      SwaggerUIStandalone.download_source options.output, repo: options.repo, ref: options.ref
    end
  end
end
