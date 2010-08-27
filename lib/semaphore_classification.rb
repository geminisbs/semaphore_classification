require 'uri'
require 'nokogiri'
require 'rest_client'

require 'semaphore_classification/connection'
require 'semaphore_classification/client'

module Semaphore
  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))
  
  class SemaphoreError < StandardError; end
  class InsufficientArgs < SemaphoreError; end
  class Unauthorized < SemaphoreError; end
  class NotFound < SemaphoreError; end
  class ServerError < SemaphoreError; end
  class Unavailable < SemaphoreError; end
  class DecodeError < SemaphoreError; end
  class RealmNotSpecified < SemaphoreError; end
end
