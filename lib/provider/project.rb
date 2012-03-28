module TicketMaster::Provider
  module Bugherd
    # Project class for ticketmaster-bugherd
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = BugherdAPI::Project # The class to access the api's projects
      # declare needed overloaded methods here
      
      def initialize(*object) 
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
              hash = {:id => object.id,
                      :name => object.name} 
          else
            hash = object
          end
          super hash
        end
      end
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

    end
  end
end


