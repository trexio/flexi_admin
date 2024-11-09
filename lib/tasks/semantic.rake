# Rakefile or tasks/semantic.rake
require "semantic"
require "rake"

namespace :semantic do
  desc "Increment the gem version stored in .gem-version"
  task :increment, [:kind] do |_t, args|
    version_file = FlexiAdmin::VERSION_FILE

    # Check if the .gem-version file is changed in the current commit
    if `git diff --name-only HEAD`.split("\n").include?(version_file)
      puts ".gem-version file has been changed in the current commit. Exiting task without changes."
      exit 0
    end

    # Default increment kind to patch if not provided
    increment_kind = args[:kind] || "patch"

    # Check if the file exists, if not create it with initial version 0.0.1
    File.write(version_file, "0.0.1") unless File.exist?(version_file)

    # Read the current version from the file
    current_version = File.read(version_file).strip

    # Parse the current version using Semantic::Version
    version = Semantic::Version.new(current_version)

    # Increment the version based on the kind provided
    case increment_kind
    when "major"
      version = version.increment!(:major)
    when "minor"
      version = version.increment!(:minor)
    when "patch"
      version = version.increment!(:patch)
    else
      raise "Invalid increment kind: #{increment_kind}. Valid kinds are: major, minor, patch."
    end

    replace_version_in_version_file(version.to_s)

    # Write the new version back to the file
    File.write(version_file, version.to_s)

    # Output the new version
    puts "Version updated to #{version}"
  end
end

def replace_version_in_version_file(new_version)
  file = File.read("lib/flexi_admin/version.rb")
  file.gsub!(/VERSION = ".*"/, "VERSION = \"#{new_version}\"")
  File.write("lib/flexi_admin/version.rb", file)
end
