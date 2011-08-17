require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketmasterBugherd" do
  before(:each) do 
    @tm = TicketMaster.new(:bugherd, :email => 'user@bugherd.com', :password => '123456')
    headers = {'Authorization' => 'Basic dXNlckBidWdoZXJkLmNvbToxMjM0NTY=', 'Accept' => 'application/xml'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/api_v1/users.xml', headers, fixture_for('users', 'xml'), 200
    end
  end

  context "Initialization and validation" do 
    it "should be able to initialize a ticketmaster object" do
      @tm.should be_an_instance_of(TicketMaster)
      @tm.should be_a_kind_of(TicketMaster::Provider::Bugherd)
    end

    it "should validate the ticketmaster instance" do 
      @tm.valid?.should be_true
    end
  end

  context "Raise exceptions" do 
    it "should raise an exception without email or password" do 
      lambda { @tm = TicketMaster.new(:bugherd, :email => '', :password => '') }.should raise_error
    end

    it "should raise an exception with an user message" do 
      lambda { @tm = TicketMaster.new(:bugherd, :email => '', :password => '')}.should raise_error("You must provide email and password for authentication")
    end
  end


end
