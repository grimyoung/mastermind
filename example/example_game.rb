root = File.expand_path("../", File.dirname(__FILE__))
require "#{root}/mastermind.rb"

Mastermind::Game.new().play