require 'rubygems'
require 'minitest'
require 'open4'

require "minitest/autorun"

class CompareTest < Minitest::Test
  def test_compare
    branch_1_files = Dir[File.expand_path(File.join('..', '..', 'tmp', 'screenshots', ENV['BRANCH_1'], '*.png'), __FILE__)]
    branch_2_files = Dir[File.expand_path(File.join('..', '..', 'tmp', 'screenshots', ENV['BRANCH_2'], '*.png'), __FILE__)]
    puts "let's run the comparison between branches #{ENV['BRANCH_1']} and #{ENV['BRANCH_2']}"
    diff_path = File.expand_path(File.join('..', '..', 'tmp', 'screenshots', 'diff'), __FILE__)
    puts diff_path
    FileUtils.mkdir_p(diff_path)

    results = []

    branch_1_files.each_with_index  do |branch_1_file, i|
      diff_file = File.join(diff_path, File.basename(branch_1_file))
      puts "  #{i} #{branch_1_file}"
      puts "    #{branch_2_files[i]}"
      puts "    #{diff_file}"

      output = nil
      status = run_comparison(branch_1_files[i], branch_2_files[i], 'ae', '2%', diff_file) do |out|
        output = out
      end

      same = false
      red  = green = blue = alpha = all = '_'
      if status.success?
        same, red, green, blue, alpha, all = unpack_comparison_results(output)
      else
        same  = false
        red   = green = blue  = alpha = all   = 'XX'
        file_diff = 'none'
      end

      results << same
      puts "    >> same = #{same.to_s.upcase}"
      puts '-'*45
    end

    failed_count = results.select{ |result| !result }.count

    assert_equal 0, failed_count, "There were #{failed_count} comparison failures"
  end

  private
  def unpack_comparison_results(packed, &unpacked)
    outputs = packed.split(/\n/)

    outputs.map! do |o|
      o.strip if o.strip.start_with?('red', 'green', 'blue', 'alpha', 'all')
    end
    outputs.compact!

    red   = ''
    green = ''
    blue  = ''
    alpha = ''
    all   = ''

    same = true
    outputs.each do |o|
      parts = o.split(' ')
      same = same && parts[1].to_f == 0

      red   = parts[1] if parts[0].start_with?('red')
      green = parts[1] if parts[0].start_with?('green')
      blue  = parts[1] if parts[0].start_with?('blue')
      alpha = parts[1] if parts[0].start_with?('alpha')
      all   = parts[1] if parts[0].start_with?('all')
    end

    return [same, red, green, blue, alpha, all]
    #yield(same, red, green, blue, alpha, all)
  end

  def run_comparison(file_1, file_2, metric, fuzz_factor, resulting_file, &b)
    imagemagick_command = "compare -verbose -metric #{metric} -fuzz #{fuzz_factor} #{file_1} #{file_2} #{resulting_file}"

    output = nil
    status = Open4::popen4(imagemagick_command) do |pid, stdin, stdout, stderr|
      output = stderr.read
    end

    yield(output) if b

    status
  end
end




