module TicketMaster::Provider
  module Bugherd
    # Ticket class for ticketmaster-bugherd
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = BugherdAPI::Task# The class to access the api's tickets
      # declare needed overloaded methods here
      
    end
  end
end
