module TicketMaster::Provider
  module Bugherd
    # Ticket class for ticketmaster-bugherd
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = BugherdAPI::Task# The class to access the api's tickets
      # declare needed overloaded methods here
      

      def self.find(project_id, *options)
        if options.first.empty?
          API.find(:all, :params => {:project_id => project_id}).collect { |task| self.new task }  
        end
      end
    end
  end
end
