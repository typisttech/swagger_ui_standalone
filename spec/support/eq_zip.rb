# frozen_string_literal: true

RSpec::Matchers.define :eq_zip do |expected|
  match do |actual|
    actual_files = zip_content_hashes actual
    expected_files = zip_content_hashes expected

    expect(actual_files).to eq(expected_files)
  end

  private

  def zip_content_hashes(path)
    zip_stream = Zip::InputStream.new(File.open(path))
    content_hash = {}

    while (entry = zip_stream.get_next_entry)
      next unless entry.file?

      i = entry.name.index("/")
      name = entry.name[i..]

      content = entry.get_input_stream.read
      content_hash[name] = Digest::MD5.hexdigest content
    end

    content_hash
  end
end
