module TaskMapper::Provider
  module Bugherd
    # Ticket class for taskmapper-bugherd
    #

    class Ticket < TaskMapper::Provider::Base::Ticket
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

      def project_id
        self.system_data[:client].prefix_options[:project_id]
      end

      def assignee
        user = BugherdAPI::User.find(:all).select do |bugherd_user|
          bugherd_user.id == self[:assigned_to_id]
        end.first
        "#{user.name} #{user.surname}"
      end

      def self.search(project_id, options = {}, limit= 1000) 
        API.find(:all, :params => {:project_id => project_id}).map do |task|
          self.new task
        end
      end

    end
  end
end
