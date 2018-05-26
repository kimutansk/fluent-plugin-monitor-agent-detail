#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

# 1. update ChangeLog and VERSION
# 2. bundle && bundle exec rake build:all
# 3. release 3 packages built on pkg/ directory
namespace :build do
  desc 'Build gems for all platforms'
  task :all do
    Bundler.with_clean_env do
      %w[ruby x86-mingw32 x64-mingw32].each do |name|
        ENV['GEM_BUILD_FAKE_PLATFORM'] = name
        Rake::Task["build"].execute
      end
    end
  end
end

task default: [:test]
