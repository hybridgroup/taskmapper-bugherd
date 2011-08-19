require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Bugherd::Ticket" do 

  before(:each) do 
    headers = { 'Authorization' => 'Basic Z2VvcmdlLnJhZmFlbEBnbWFpbC5jb206MTIzNDU2', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock| 
      mock.get '/api_v1/projects/1458.xml', headers, fixture_for('/projects/1458', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks.xml', headers, fixture_for('tasks', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950.xml',  headers, fixture_for('/tasks/4950', 'xml'), 200
    end
    @tm = TicketMaster.new(:bugherd, :email => 'george.rafael@gmail.com', :password => '123456')
    @project = @tm.project(1458)
    @klass = TicketMaster::Provider::Bugherd::Ticket
  end

  context "Loading all tickets" do 
    it "should be able to load all tickets" do 
      tickets = @project.tickets
      tickets.should be_an_instance_of(Array)
      tickets.first.should be_an_instance_of(@klass)
    end

    it "should be able to load all tickets based on an array of id's" do 
      tickets = @project.tickets([4950]) 
      tickets.should be_an_instance_of(Array)
      tickets.first.should be_an_instance_of(@klass)
    end

    it "should be able to load all tickets based on attributes" do 
      tickets = @project.tickets(:id => 4950)
      tickets.should be_an_instance_of(Array)
      tickets.first.should be_an_instance_of(@klass)
    end
  end

  context "Loading a single ticket" do 
    it "should be able to load a single ticket based on id" do 
      ticket = @project.ticket(4950)
      ticket.should be_an_instance_of(@klass)
    end

    it "should be able to load a single ticket based on attributes" do 
      ticket = @project.ticket(:id => 4950)
      ticket.should be_an_instance_of(@klass)
    end
  end

  it "should contain all fields for tickets" do 
    ticket = @project.ticket(4950)
    ticket.id.should == 4950
    ticket.status.should == 2
    ticket.priority.should be_nil
    ticket.title.should be_nil
    ticket.resolution.should be_nil
    ticket.created_at.should be_nil
    ticket.updated_at.should be_nil
    ticket.description.should == ''
    ticket.assignee.should == ''
    ticket.requestor.should == ''
    ticket.project_id.should == 1458
  end
end
