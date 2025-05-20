# frozen_string_literal: true

require "thor"
require_relative "../swagger_ui_standalone"

module SwaggerUIStandalone
  class CLI < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    no_commands do
      def copy_directory(source, destination, config = {})
        absolute_source = File.absolute_path(source)

        self.class.source_root File.dirname(absolute_source)
        @source_paths = nil

        directory File.basename(absolute_source), destination, config
      end
    end

    def self.define_download_options
      option :output,
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
      option :force,
        type: :boolean,
        desc: "Overwrite files that already exist"
    end

    desc "generate [options]", "Generate standalone static Swagger UI"
    option :custom,
      type: :string,
      desc: "Path to the directory containing custom files, which will be copied to the output directory",
      banner: "DIRECTORY",
      required: true
    define_download_options

    def generate
      Dir.mktmpdir do |tmp_dir|
        # We only want the dist directory.
        tmp_dist_dir = File.join(tmp_dir, DIST_DIR)

        SwaggerUIStandalone.download_source tmp_dir, repo: options.repo, ref: options.ref
        copy_directory options[:custom], tmp_dist_dir, recursive: true, force: true, verbose: false

        copy_directory tmp_dist_dir, options.output, recursive: true, force: options.force, verbose: true
      end
    end

    desc "download [options]", "Download standalone static Swagger UI source code"
    define_download_options

    def download
      Dir.mktmpdir do |tmp_dir|
        SwaggerUIStandalone.download_source tmp_dir, repo: options.repo, ref: options.ref

        # We only want the dist directory.
        copy_directory File.join(tmp_dir, DIST_DIR), options.output, recursive: true, force: options.force, verbose: true
      end
    end
  end
end
