require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BrmClient" do
  
  before(:each) do 
    application = "brm_client_test"
    # @logger = BrmClient::Logger.new(application, "File")
    # @logger = BrmClient::Logger.new(application, "Amqp", { :host => "10.101.0.215", :vhost => "/" })
  end
  
  after(:each) do
    @logger.disconnect
  end
  
  it "should send custom events" do
    10.times { |i| @logger.message("think", { "id" => "123", "type" => "facet" }, "Salut #{i}") }
  end
end
