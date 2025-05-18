# frozen_string_literal: true

RSpec.describe SwaggerUIStandalone::HTTP do
  subject { Class.new { extend SwaggerUIStandalone::HTTP } }

  describe "#download" do
    it "downloads a file" do
      url = "https://codeload.github.com/swagger-api/swagger-ui/legacy.zip/refs/tags/v5.21.0"
      downloaded = subject.download(url)
      expect(downloaded).to eq_zip(file_fixture("swagger-ui-5.21.0.zip"))
    end
  end
end
