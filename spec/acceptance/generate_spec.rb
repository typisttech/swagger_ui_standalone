# frozen_string_literal: true

RSpec.describe SwaggerUIStandalone::CLI, "generate" do
  it "generates specific ref's swagger-ui dist folder with custom files" do
    Dir.mktmpdir do |dir|
      allow($stdout).to receive(:write)
      described_class.new.invoke(:generate, [], custom: file_fixture("custom"), output: dir, ref: "v5.21.0")
      expect(dir).to eq_dir(file_fixture("golden"))
    end
  end
end
