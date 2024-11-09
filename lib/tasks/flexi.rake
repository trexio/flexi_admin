namespace :flexi do
  desc "Generate code for a given entity"
  task :codegen, [:prompt] => :environment do |_t, _args|
    prompt = ENV["prompt"]

    abort "prompt is required" if prompt.nil? || prompt.strip.empty?

    Flexi::Services::CodeGen.execute(prompt)
  end
end
