require 'rubygems'
require 'rake'
require 'fileutils'

namespace :appearance do
  desc 'compile appearance test screenshots'
  Rake::TestTask.new(:compile) do |t|
    t.libs << 'test'
    t.pattern = 'test/appearance/**/*_test.rb'
  end
end
