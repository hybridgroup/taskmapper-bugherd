require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapperBugherd" do
  before(:each) do 
    headers = {'Authorization' => 'Basic Z2VvcmdlLnJhZmFlbEBnbWFpbC5jb206MTIzNDU2', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock| 
      @tm = TaskMapper.new(:bugherd, :email => 'george.rafael@gmail.com', :password => '123456')
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get '/api_v1/users.xml', headers, fixture_for('users', 'xml'), 200
      end
    end

    context "Initialization and validation" do 
      it "should be able to initialize a taskmapper object" do
        @tm.should be_an_instance_of(TaskMapper)
        @tm.should be_a_kind_of(TaskMapper::Provider::Bugherd)
      end

      it "should validate the taskmapper instance" do 
        @tm.valid?.should be_true
      end
    end

    context "Raise exceptions" do 
      it "should raise an exception without email or password" do 
        lambda { @tm = TaskMapper.new(:bugherd, :email => '', :password => '') }.should raise_error
      end

      it "should raise an exception with an user message" do 
        lambda { @tm = TaskMapper.new(:bugherd, :email => '', :password => '')}.should raise_error("You must provide email and password for authentication")
      end
    end
  end
end
