# frozen_string_literal: true

RSpec.describe SwaggerUIStandalone::Zipball do
  subject { Class.new { extend SwaggerUIStandalone::Zipball } }

  describe "#extract" do
    it "extracts a subdirectory from zip archives" do
      Dir.mktmpdir do |dir|
        subject.extract(file_fixture("swagger-ui-5.21.0.zip"), pattern: "*/dist/**", destination_directory: dir)
        expect(dir).to eq_dir(file_fixture("swagger-ui-5.21.0"))
      end
    end
  end
end
