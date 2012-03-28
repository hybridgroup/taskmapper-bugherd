module TicketMaster::Provider
  module Bugherd
    # Ticket class for ticketmaster-bugherd
    #

    class Ticket < TicketMaster::Provider::Base::Ticket
      API = BugherdAPI::Task# The class to access the api's tickets
      STATUS = %w{new todo active declined fixed closed}
      PRIORITY = %w{- critical important normal minor}
      # declare needed overloaded methods here


      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:id => object.id,
              :status_id => object.status_id,
              :priority_id => object.priority_id,
              :assigned_to_id => object.assigned_to_id,
              :created_at => object.created_at,
              :updated_at => object.updated_at,
              :description => object.description}
          else
            hash = object
          end
          super hash
        end
      end

      def status
        STATUS[self[:status_id]]
      end

      def priority
        self[:priority_id].nil? ? "" : PRIORITY[self[:priority_id]]
      end

      def assignee
        user = BugherdAPI::User.find(:all).select do |user|
          user.id == self[:assigned_to_id]
        end.first
        "#{user.name} #{user.surname}"
      end

      def self.search(project_id, options = {}, limit = 1000)
        API.find(:all, :params => {:project_id => project_id}).collect do |task|
          task = task.merge!(:project_id => project_id)
          self.new task
        end
      end

    end
  end
end
