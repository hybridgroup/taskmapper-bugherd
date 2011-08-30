require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Bugherd::Project" do 
  before(:each) do 
    headers = {'Authorization' => 'Basic dXNlckBlbWFpbC5jb206MDAwMA==', 'Accept' => 'application/xml'}
    @tm = TicketMaster.new(:bugherd, :email => 'user@email.com',
                           :password => '0000')
    @klass = TicketMaster::Provider::Bugherd::Project
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api_v1/projects.xml', headers, fixture_for('projects', 'xml'), 200
      mock.get '/api_v1/projects/1458.xml', headers, fixture_for('/projects/1458', 'xml'), 200
    end
    @project_id = 1458
  end

  context "Loading all projects" do 
    it "should be able to retrieve all projects" do 
      projects = @tm.projects
      projects.should be_an_instance_of(Array)
      projects.first.should be_an_instance_of(@klass)
    end

    it "should be able to retrieve all projects based on an array of id's" do 
      projects = @tm.projects([@project_id])
      projects.should be_an_instance_of(Array)
      projects.first.should be_an_instance_of(@klass)
    end

    it "should be able to retrieve all projects using attributes" do 
      projects = @tm.projects(:id => @project_id)
      projects.should be_an_instance_of(Array)
      projects.first.should be_an_instance_of(@klass)
    end
  end

  context "Loading a single project" do 
    it "should be able to retrieve a single project based on id" do 
      project = @tm.project(@project_id)
      project.should be_an_instance_of(@klass)
    end

    it "should be able to retrieve a single project based on attributes" do 
      project = @tm.project(:id => @project_id)
      project.should be_an_instance_of(@klass)
    end
  end

  context "Project creation and update" do 
    it "should be able to create a project"
    it "should be able to update a project" 
  end

  it "should contain all mandatory fields for projects" do 
    project = @tm.project(@project_id)
    project.id.should == 1458
    project.name.should == 'clutchapptest'
    project.created_at.should_not be_nil
  end
end
