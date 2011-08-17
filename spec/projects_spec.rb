require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Bugherd::Project" do 
  before(:each) do 
    @tm = TicketMaster.new(:bugherd, :email => 'user@bugherd.com', :password => '123456')
    headers = {'Authorization' => 'Basic dXNlckBidWdoZXJkLmNvbToxMjM0NTY=', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api_v1/projects.xml', headers, fixture_for('projects', 'xml'), 200
    end
  end


  context "Retreiving projects" do 
    it "should return all projects" do 
      projects = @tm.projects
      projects.should be_an_instance_of(Array)
      projects.first.should be_an_instance_of(TicketMaster::Provider::Bugherd::Project)
    end
  end
end
