$LOAD_PATH << File.expand_path("../../../lib", __FILE__)
ENV["PATH"] += ":" + File.expand_path("../../../bin", __FILE__)
require "rubygems"
require "bundler/setup"
require "aruba/cucumber"
require "pontifex"
