require 'rubygems'
require 'rake'

namespace :test do
  desc "selenium tests"
  Rake::TestTask.new(:selenium) do |t|
    t.libs << 'test'
    t.pattern = 'test/selenium/**/*_test.rb'
  end

  namespace :selenium do
    desc 'selenium tests on SauceLabs'
    task :sauce do
      ENV['SAUCE'] = 'true'
      Rake::Task['test:selenium'].invoke
    end
  end
end

# task :test => [ 'test:units', 'test:functionals', 'test:integration', 'test:selenium' ]

# task :default => :test
