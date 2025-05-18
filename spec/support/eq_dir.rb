# frozen_string_literal: true

RSpec::Matchers.define :eq_dir do |expected|
  match do |actual|
    actual_files = dir_content_hashes actual
    expected_files = dir_content_hashes expected

    expect(actual_files).to eq(expected_files)
  end

  private

  def dir_content_hashes(path)
    Dir.glob("**/**", base: path)
      .select { |entry| File.file? File.join(path, entry) }
      .to_h { |entry| [entry, File.join(path, entry)] }
      .transform_values { |entry| Digest::MD5.hexdigest(File.read(entry)) }
  end
end
