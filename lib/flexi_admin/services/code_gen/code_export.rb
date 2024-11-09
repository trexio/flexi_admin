# frozen_string_literal: true

module FlexiAdmin::Services::CodeGen
  class CodeExport
    def self.export_codebase
      exclusions = [
        "app/assets/builds/"
      ]
      File.open("tmp/codebase.txt", "w") do |file|
        Dir.glob("app/**/*").each do |filename|
          next if exclusions.any? { |exclusion| filename.include?(exclusion) }

          next unless File.file?(filename)

          file.puts "#filecontent: #{filename}"
          file.puts File.read(filename)
          file.puts "\n"
        end
      end
    end
  end
end
