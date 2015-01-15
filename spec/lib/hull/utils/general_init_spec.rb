require_relative '../../../../lib/hull/utils/general_init'
module Hull
  module Utils
    class Test
      include Hull::Utils::GeneralInit
      attr_accessor :test_param1, :test_param2  
    end
  end
end


describe Hull::Utils::GeneralInit do  
  describe "#intialize" do
    it "including the module GeneralInit with a class will enable the it to be instantiated with a hash" do
       t = Hull::Utils::Test.new({ test_param1: "param1", test_param2: "param2"})
    end
  end
end