# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'podcast_updater/version'

Gem::Specification.new do |s|
  s.name = "podcast_updater"
  s.version = PodcastUpdater::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tony Miller"]
  s.date = "2013-03-12"
  s.description = "Update your podcast feed.\nFix your mp3 tags and upload your mp3s to S3 along the way."
  s.email = ["mcfiredrill@gmail.com"]
  s.executables = ["podcast_updater"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage = "http://github.com/datafruits/podcast_updater"
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "podcast_updater"
  s.rubygems_version = "1.8.25"
  s.summary = "Update your podcast feed"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.5"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.5"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.5"])
  end
end
