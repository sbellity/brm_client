$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require "rubygems"
require "active_support"

require "brm_client/event"
require "brm_client/logger"
require "brm_client/gateway"

module BrmClient
  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp
end
