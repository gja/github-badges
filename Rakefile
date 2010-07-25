require 'spec/rake/spectask'

Spec::Rake::SpecTask.new("spec") do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task :repl do
  system "irb -Ilib -r lib/github_badges"
end

task :server do
  system "shotgun -Ilib -Edevelopment -p4567 lib/github_badges.rb"
end

task :default => :spec