# encoding: utf-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'fluent-plugin-monitor-agent-detail'
  gem.description = 'outputs detail monitor informations for fluentd'
  gem.homepage    = 'https://github.com/kimutansk/fluent-plugin-monitor-agent-detail'
  gem.summary     = gem.description
  gem.version     = File.read('VERSION').strip
  gem.authors     = ['Kimura, Sotaro']
  gem.email       = 'rfbringer@gmail.com'
  gem.has_rdoc    = false
  gem.license     = "Apache-2.0"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  # build gem for a certain platform. see also Rakefile
  fake_platform = ENV['GEM_BUILD_FAKE_PLATFORM'].to_s
  gem.platform = fake_platform unless fake_platform.empty?
  if /mswin|mingw/ =~ fake_platform || (/mswin|mingw/ =~ RUBY_PLATFORM && fake_platform.empty?)
    gem.add_runtime_dependency("win32-service", ["~> 0.8.3"])
    gem.add_runtime_dependency("win32-ipc", ["~> 0.6.1"])
    gem.add_runtime_dependency("win32-event", ["~> 0.6.1"])
    gem.add_runtime_dependency("windows-pr", ["~> 1.2.5"])
  end

  gem.add_dependency 'fluentd', ['>= 0.14.0', '< 2']
  gem.add_development_dependency("rake", ["~> 11.0"])
  gem.add_development_dependency("flexmock", ["~> 2.0"])
  gem.add_development_dependency("parallel_tests", ["~> 0.15.3"])
  gem.add_development_dependency("simplecov", ["~> 0.7"])
  gem.add_development_dependency("rr", ["~> 1.0"])
  gem.add_development_dependency("timecop", ["~> 0.3"])
  gem.add_development_dependency("test-unit", ["~> 3.2"])
  gem.add_development_dependency("test-unit-rr", ["~> 1.0"])
  gem.add_development_dependency("oj", ["~> 2.14"])
end
