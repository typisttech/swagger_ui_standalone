RSpec.describe SwaggerUIStandalone::CLI, "download" do
  it "downloads specific ref's swagger-ui dist folder" do
    Dir.mktmpdir do |dir|
      described_class.new.invoke(:download, [], output: dir, ref: "v5.21.0")
      expect(dir).to eq_dir(file_fixture("swagger-ui-5.21.0-dist"))
    end
  end
end
