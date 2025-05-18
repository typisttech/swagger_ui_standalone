# frozen_string_literal: true

RSpec.describe SwaggerUIStandalone::GitHub do
  subject { Class.new { extend SwaggerUIStandalone::GitHub } }

  describe "#archive_link" do
    it "returns a link" do
      url = "https://codeload.github.com/swagger-api/swagger-ui/legacy.zip/refs/tags/v5.21.0"
      expect(subject.archive_link("swagger-api/swagger-ui", "v5.21.0")).to eq(url)
    end
  end

  describe "#latest_release_archive_link" do
    it "returns a string" do
      expect(subject.latest_release_archive_link("swagger-api/swagger-ui")).to be_a(String)
    end
  end
end
