module TaskMapper::Provider
  module Bugherd
    # The comment class for taskmapper-bugherd
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      API = BugherdAPI::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      #
      
      def initialize(*object) 
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
             hash = {:id => object.id,
                     :created_at => object.created_at,
                     :body => object.text,
                     :user_id => object.user_id,
                     :ticket_id => object.prefix_options[:task_id],
                     :project_id => object.prefix_options[:project_id]}
          else
            hash = object
          end
          super hash
        end
      end

      def author
        author = BugherdAPI::User.find(:all).select do |user|
          user.id == self[:user_id]
        end.first
        "#{author.name} #{author.surname}" 
      end

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
