# frozen_string_literal: true

require "octokit"

module SwaggerUIStandalone
  module GitHub
    def archive_link(repo, ref)
      Octokit.archive_link(repo, format: "zipball", ref: ref)
    end

    def latest_release_archive_link(repo)
      Octokit.latest_release(repo).zipball_url
    end
  end
end
