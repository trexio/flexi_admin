# frozen_string_literal: true

module FlexiAdmin
  VERSION_FILE = ".gem-version"
  VERSION = File.read(VERSION_FILE).strip

  def self.version
    VERSION
  end
end
