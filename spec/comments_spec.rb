require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Bugherd::Comment do 
  before(:each) do 
    @tm = TaskMapper.new(:bugherd, :email => 'user@email.com',
                           :password => '0000')
    @klass = TaskMapper::Provider::Bugherd::Comment
    headers = {'Authorization' => 'Basic dXNlckBlbWFpbC5jb206MDAwMA==', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api_v1/projects/1458.xml', headers, fixture_for('projects/1458', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950.xml', headers, fixture_for('tasks/4950', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950/comments.xml', headers, fixture_for('comments', 'xml'), 200
      mock.get '/api_v1/projects/1458/tasks/4950/comments/9760.xml', headers, fixture_for('comments/9760', 'xml'), 200
      mock.get '/api_v1/users.xml', headers, fixture_for('users', 'xml'), 200
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

  it "should retrieve all comments based on an array of id's" do 
    comments = @ticket.comments([9760])
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to retrieve a single comment based on id" do 
    comment = @ticket.comment(9760)
    comment.should be_an_instance_of(@klass)
  end

  it "should be able to retrieve a single comment based on attributes" do 
    comment = @ticket.comment(:id => 9760)
    comment.should be_an_instance_of(@klass)
  end

  it "should have all valid fields for a comment" do 
    comment = @ticket.comment(9760)
    comment.author.should == 'Rafael George'
    comment.body.should == "I'm working on this already"
    comment.id.should == 9760
    comment.ticket_id.should == 4950
    comment.project_id.should == 1458
    comment.updated_at.should be_nil
    comment.created_at.should_not be_nil
  end
end
