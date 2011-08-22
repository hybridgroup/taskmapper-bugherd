module TicketMaster::Provider
  module Bugherd
    # Ticket class for ticketmaster-bugherd
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = BugherdAPI::Task# The class to access the api's tickets
      STATUS = %w{new todo active declined fixed closed}
      PRIORITY = %w{- critical important normal minor}
      # declare needed overloaded methods here
      
      def status
        STATUS[self[:status_id]]
      end

      def priority
        PRIORITY[self[:priority_id]]
      end

      def assignee
        user = BugherdAPI::User.find(:all).select do |user|
          user.id == self[:assigned_to_id]
        end.first
        "#{user.name} #{user.surname}"
      end

      def project_id
        self.prefix_options[:project_id]
      end

      def self.search(project_id, options = {}, limit = 1000)
        API.find(:all, :params => {:project_id => project_id}).collect do |task|
          self.new task
        end
      end

      def comments(*options)
        warn "Bugherd API doesn't support comments"
        []
      end

    end
  end
end
