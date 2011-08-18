require 'rubygems'
require 'active_support'
require 'active_resource'

module BugherdAPI
  class Error < StandardError; end

  class << self
    def authenticate(email, password)
      @email = email 
      @password = password
      self::Base.user = email
      self::Base.password = password
    end

    def resources
      @resources ||= []
    end
  end

  class Base < ActiveResource::Base
    self.format = :xml
    self.site = 'http://www.bugherd.com/api_v1/'
    def self.inherited(base)
      BugherdAPI.resources << base
      super
    end
  end

  class User < Base
  end

  class Project < Base
  end

  class Task < Base
    self.site += '/projects/:project_id/'
  end
end
