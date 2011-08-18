require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Bugherd::Ticket" do 

  before(:each) do 
    headers = { 'Authorization' => 'Basic Z2VvcmdlLnJhZmFlbEBnbWFpbC5jb206MTIzNDU2', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock| 
      mock.get '/api_v1/projects/1458.xml', headers, fixture_for('1458', 'xml'), 200
      mock.get '/projects/1458/tasks.xml', headers, fixture_for('tasks', 'xml'), 200
    end
    @project_id = 1458
  end

  context "Loading all tickets" do 
    it "should be able to load all tickets" do 
      @tm = TicketMaster.new(:bugherd, :email => 'george.rafael@gmail.com', :password => '123456')
      project = @tm.project(1458)
      tickets = project.tickets
      tickets.should be_an_instance_of(Array)
      tickets.first.should be_an_instance_of(TicketMaster::Provider::Bugherd::Ticket)
    end
  end
end
