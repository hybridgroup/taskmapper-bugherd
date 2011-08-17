module TicketMaster::Provider
  # This is the Bugherd Provider for ticketmaster
  module Bugherd
    include TicketMaster::Provider::Base
    #TICKET_API = Bugherd::Ticket # The class to access the api's tickets
    #PROJECT_API = Bugherd::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Bugherd.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:bugherd, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if (auth.email.empty? || auth.password.empty?)
        raise "You must provide email and password for authentication"
      end
      BugherdAPI.authenticate(auth.email, auth.password)
      # Set authentication parameters for whatever you're using to access the API
    end
    
    # declare needed overloaded methods here
    def valid?
      begin
        BugherdAPI::User.find(:first)
        true
      rescue
        false
      end
    end

  end
end


