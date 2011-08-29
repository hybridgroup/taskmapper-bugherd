module TicketMaster::Provider
  module Bugherd
    # The comment class for ticketmaster-bugherd
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      API = BugherdAPI::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
      def self.search(project_id, ticket_id, options = {}, limit = 1000)
        API.find(:all, :params => {:project_id => project_id, :task_id => ticket_id}).collect do |comment|
          self.new comment
        end
      end

      def self.find_by_id(project_id, ticket_id, id)
        self.new API.find(id, :params => {:project_id => project_id, :task_id => ticket_id})
      end
    end
  end
end
