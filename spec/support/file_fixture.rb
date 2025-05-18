# frozen_string_literal: true

def file_fixture(fixture_name)
  file_fixture_path = File.join(File.dirname(__FILE__), "../fixtures")

  path = Pathname.new(File.join(file_fixture_path, fixture_name))

  if path.exist?
    path
  else
    msg = "the directory '%s' does not contain a file named '%s'"
    raise ArgumentError, msg % [file_fixture_path, fixture_name]
  end
end
