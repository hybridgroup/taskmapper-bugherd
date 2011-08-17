require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketmasterBugherd" do
  before(:each) do 
    @tm = TicketMaster.new(:bugherd, :email => 'user@bugherd.com', :password => '123456')
  end

  it "should be able to initialize a ticketmaster object" do
    @tm.should be_an_instance_of(TicketMaster)
    @tm.should be_a_kind_of(TicketMaster::Provider::Bugherd)
  end

  it "should raise an exception without email or password" do 
     lambda { @tm = TicketMaster.new(:bugherd, :email => '', :password => '') }.should raise_error
  end

end
