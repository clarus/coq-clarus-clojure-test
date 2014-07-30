require 'fileutils'

Dir.glob("*.v") do |filename|
  puts "#{filename}:"
  system("coqc", filename)
  FileUtils.mv("extraction.clj", "../sample-app/src/")
  system("sed s/%%example-name%%/#{File.basename(filename, ".v")}/ ../sample-app/src/sample_app/core.clj.template > ../sample-app/src/sample_app/core.clj")
  system("cd ../sample-app && lein run")
end