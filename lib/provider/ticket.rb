module TicketMaster::Provider
  module Bugherd
    # Ticket class for ticketmaster-bugherd
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = BugherdAPI::Task# The class to access the api's tickets
      # declare needed overloaded methods here
      
      def status
        self[:status_id]
      end

      def self.search(project_id, options = {}, limit = 1000)
        API.find(:all, :params => {:project_id => project_id}).collect do |task|
          self.new task
        end
      end

    end
  end
end
