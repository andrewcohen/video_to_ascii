# -*- encoding: utf-8 -*-
require File.expand_path('../lib/video_to_ascii/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["andrewcohen"]
  gem.email         = ["andrew@eastmedia.com"]
  #gem.description   = %q{Write a gem description}
  gem.summary       = %q{A Command line tool to take a video from your iSight camera and play it back as ASCII art}
  gem.homepage      = "https://github.com/andrewcohen/video_to_ascii"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "video_to_ascii"
  gem.require_paths = ["lib"]
  gem.version       = VideoToAscii::VERSION

  gem.add_dependency('asciiart', '0.0.2')
  gem.add_dependency('streamio-ffmpeg')
  gem.add_dependency('highline')

  gem.add_development_dependency('pry')
end
