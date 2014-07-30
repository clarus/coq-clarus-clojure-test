require 'fileutils'

Dir.glob("*.v") do |filename|
  system("coqc", filename)
  FileUtils.mv("extraction.clj", "../sample-app/src/")
  system("sed s/%%example-name%%/#{File.basename(filename, ".v")}/g ../sample-app/src/sample_app/core.clj.template > ../sample-app/src/sample_app/core.clj")
  system("cd ../sample-app && lein run")
end