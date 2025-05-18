# frozen_string_literal: true

require "down/net_http"

module SwaggerUIStandalone
  module HTTP
    def download(url)
      Down::NetHttp.download url
    end
  end
end
