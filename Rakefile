require 'spec/rake/spectask'

Spec::Rake::SpecTask.new("spec") do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task :repl do
  system "irb -Ilib -r lib/github_badges"
end

task :server do
  system "rackup -E development -p 4567 config.ru"
end

task :default => :spec

