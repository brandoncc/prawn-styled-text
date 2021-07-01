require "minitest/autorun"
require "identikal"

class TestPrawnStyledText < Minitest::Test
  def setup
    FileUtils.mkdir_p(File.expand_path("#{__dir__}/tmp"))
  end

  def teardown
    FileUtils.rm_rf(File.expand_path("#{__dir__}/tmp"))
  end

  def test_the_correct_examples_are_generated
    examples_dir = File.expand_path("#{__dir__}/../examples")
    fixtures_dir = File.expand_path("#{__dir__}/fixtures")
    output_dir = File.expand_path("#{__dir__}/tmp")
    Dir.chdir(examples_dir) do
      Dir.glob("*.rb").each do |example|
        puts "Running: #{example}"
        `bundle exec ruby #{example} #{output_dir}`
      end
    end

    Dir.chdir(output_dir) do
      Dir.glob("*.pdf").each do |pdf|
        fixture = File.expand_path("#{fixtures_dir}/#{pdf}")
        assert File.exist?(fixture), "Fixture for #{pdf} doesn't exist"
        assert Identikal.files_same?(fixture, pdf), "Fixture for #{pdf} doesn't match the generated file"
      end
    end
  end
end
