# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))
require 'demo/application'
run Demo::Application
