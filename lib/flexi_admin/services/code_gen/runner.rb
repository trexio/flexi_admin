# frozen_string_literal: true

module FlexiAdmin::Services::CodeGen
  EXAMPLES_DIR = 'examples'

  class Runner
    SYSTEM_PROMPT_FILENAME = 'prompts/codegen-system-prompt.md'
    OUTPUT_PROMPT_FILE = 'tmp/code_gen_prompt.md'
    OUTPUT_CODE_FILE = 'tmp/code_gen_parsed_response.json'

    attr_reader :client, :model

    def initialize(client: :gemini, model: :gemini_flash)
      @client = resolve_client(client)
      @model = model
    end

    def execute(text)
      prompt = prompt(text)
      File.write OUTPUT_PROMPT_FILE, prompt

      result = client.new.chat prompt, format: :json, model: model
      File.write OUTPUT_CODE_FILE, result.as_json.to_json
      execute_response(result.as_json.dig('files'))

      result
    rescue StandardError => e
      binding.pry if Rails.env.development?
      raise e
    end

    def execute_response(array_of_hashes)
      raise "Array of hashes, expected, got #{array_of_hashes.inspect}" if !array_of_hashes.is_a?(Array)

      array_of_hashes.each do |hash|
        FileUtils.mkdir_p File.dirname(hash['filename'])
        File.write hash['filename'], hash['code']
      end
    end

    def export_codebase(output_file = 'codebase_export.txt', exclude_patterns = [])
      exclude_patterns = ['tmp/**', 'templates/**', 'examples/**', 'storage/**', 'bin/**', 'db/**', 'vendor/**', 'node_modules/**', 'public/**',
                          '*.png', '*.jpg', '*.jpeg', '*.gif', '*.lock', '*.log', '*.pid', '*.pid.lock',
                          '*.map', '*.gz', '*.swp', '*.swo', '*.DS_Store']

      File.open(output_file, 'w') do |file|
        Dir.glob('**/*').each do |path|
          next if exclude_patterns.any? { |pattern| File.fnmatch?(pattern, path) }
          next if File.directory?(path)
          next if File.size(path) > 100 * 1024 # Skip files larger than 100KB

          file.puts "# #{path}"
          file.puts File.read(path)
          file.puts "\n\n"
        end
      end
    end

    def system_prompt
      File.read(resolve_file_path(SYSTEM_PROMPT_FILENAME))
    end

    def gem_info
      @gem_info ||= Gem::Specification.find_by_name('flexi_admin')
    end

    def prompt(text)
      prompt = system_prompt.gsub('{{task}}', text)
      prompt.gsub('{{sample_files}}', inject_all_files)
    end

    def inject_files_and_descriptions(*objects)
      result = String.new
      objects.each do |object|
        result << "# Description\n"
        result << "#{object.description}\n\n# Files\n"
        object.files.each do |example_file|
          real_path = example_file.gsub(EXAMPLES_DIR + '/', '')
          result << "/# #{real_path}\n"
          result << "#{File.read(example_file)}\n\n" # Fetch from examples/ directory
        end
      end
      result
    end

    def inject_all_files
      inject_files_and_descriptions(show_view_files, index_view_files, bulk_action_view_files,
                                    model_files,
                                    controller_files,
                                    config_files)
    end

    def resolve_file_path(file)
      local_path = gem_info.full_gem_path
      full_path = gem_info.files.find { |f| f.include?(file) }
      File.expand_path(full_path, local_path)
    end

    def resource_files
      {
        show_views: [
          "#{EXAMPLES_DIR}/app/components/admin/observation/show/edit_form_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/show/edit_form_component.rb",
          "#{EXAMPLES_DIR}/app/components/admin/observation/show/page_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/show/page_component.rb",
          "#{EXAMPLES_DIR}/app/views/admin/observations/show.html.slim"

        ],
        index_views: [
          "#{EXAMPLES_DIR}/app/components/admin/observation/index_page_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/index_page_component.rb",
          "#{EXAMPLES_DIR}/app/components/admin/observation/resources_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/resources_component.rb",
          "#{EXAMPLES_DIR}/app/components/admin/observation/view/grid_view_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/view/grid_view_component.rb",
          "#{EXAMPLES_DIR}/app/components/admin/observation/view/list_view_component.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation/view/list_view_component.rb",
          "#{EXAMPLES_DIR}/app/views/admin/observations/index.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/nav/navbar_component.rb"
        ],
        bulk_actions: [
          "#{EXAMPLES_DIR}/app/components/admin/observation_image/action/delete_image.html.slim",
          "#{EXAMPLES_DIR}/app/components/admin/observation_image/action/delete_image.rb"
        ],
        models: [
          "#{EXAMPLES_DIR}/app/models/observation.rb"
        ],
        controllers: [
          "#{EXAMPLES_DIR}/app/controllers/admin/observations_controller.rb"
        ],
        config: [
          "#{EXAMPLES_DIR}/db/schema.rb",
          "#{EXAMPLES_DIR}/config/routes.rb"
        ]
      }
    end

    def update_resource_examples
      resource_files.each do |_type, files|
        files.each do |file|
          source = file.gsub(EXAMPLES_DIR + '/', '')
          destination = file
          dirname = File.dirname(destination)

          FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
          FileUtils.cp(source, destination)
        end
      end
    end

    def show_view_files
      description = <<~DESCRIPTION
        These are files that comprise show views of an application resource.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:show_views])
    end

    def index_view_files
      description = <<~DESCRIPTION
        These are files that comprise index views of an application resource.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:index_views])
    end

    def bulk_action_view_files
      description = <<~DESCRIPTION
        These are files that comprise components to build bulk actions.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:bulk_actions])
    end

    def model_files
      description = <<~DESCRIPTION
        These are files that comprise models of an application resource.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:models])
    end

    def controller_files
      description = <<~DESCRIPTION
        These are files that comprise controllers of an application resource.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:controllers])
    end

    def config_files
      description = <<~DESCRIPTION
        Various files describing the system setup. Current time is #{Time.now.strftime('%Y%m%d%H%M%S')}.
      DESCRIPTION

      OpenStruct.new(description:, files: resource_files[:config])
    end

    def resolve_client(client)
      case client
      when :gpt
        FlexiAdmin::Services::CodeGen::Gpt
      when :gemini
        FlexiAdmin::Services::CodeGen::Gemini
      else
        raise "Unknown client: #{client}, expected :gpt or :gemini"
      end
    end
  end
end
