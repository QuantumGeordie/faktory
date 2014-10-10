require 'rubygems'
require 'rake'

namespace :test do
  desc "selenium tests"
  Rake::TestTask.new(:selenium) do |t|
    t.libs << "test"
    t.pattern = 'test/selenium/**/*_test.rb'
    #t.verbose = true
  end

  namespace :selenium do
    desc 'selenium tests on SauceLabs'
    task :sauce do
      ENV['SAUCE'] = 'true'
      Rake::Task['test:selenium'].invoke
    end
  end

  namespace :branch_compare do
    Rake::TestTask.new(:compile) do |t|
      `git checkout #{ENV['THIS_BRANCH']}`
      current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
      raise 'wrong branch' unless current_branch == ENV['THIS_BRANCH']
      t.libs << 'test'
      t.pattern = 'test/phantomjs/**/*_test.rb'
    end

    Rake::TestTask.new(:compare) do |t|
      t.libs << 'test'
      t.pattern = 'test/branch_compare/compare.rb'
    end
  end
end

task :test => [ 'test:units', 'test:functionals', 'test:integration', 'test:selenium' ]

task :default => :test
