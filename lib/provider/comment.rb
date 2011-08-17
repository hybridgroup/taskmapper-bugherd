module TicketMaster::Provider
  module Bugherd
    # The comment class for ticketmaster-bugherd
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      #API = Bugherd::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
    end
  end
end
