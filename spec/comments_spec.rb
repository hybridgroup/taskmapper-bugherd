require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Bugherd::Comment" do 
  before(:each) do 
    @tm = TicketMaster.new(:bugherd, :email => 'user@email.com',
                           :password => '0000')
    @klass = TicketMaster::Provider::Bugherd::Comment
    headers = {'Authorization' => 'Basic dXNlckBlbWFpbC5jb206MDAwMA==', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api_v1/projects/1458.xml', headers, fixture_for('projects/1458', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950.xml', headers, fixture_for('tasks/4950', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950/comments.xml', headers, fixture_for('comments', 'xml'), 200
    end
    @project_id = 1458
    @ticket_id = 4950
    @project = @tm.project(@project_id)
    @ticket = @project.ticket(@ticket_id)
  end

  it "should retrieve all comments" do 
    @ticket.comments.should be_an_instance_of(Array)
    @ticket.comments.first.should be_an_instance_of(@klass)
  end
end
