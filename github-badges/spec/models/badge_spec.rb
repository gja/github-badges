require 'spec_helper'

describe Badge do
  context "name" do
    it "should have a short name" do
      Badge.new(:name => "Happy User").name.should == "Happy User"
    end
  end

  context "description" do
    it "should have a description" do
      Badge.new(:description => "Unhappy user").description.should == "Unhappy user"
    end
  end

  context "applicable_to?" do
    it "should always be true if given block is true" do
      Badge.new { true }.should be_applicable_to(:anything)
    end

    it "should always be false if given block is false" do
      Badge.new { false }.should_not be_applicable_to(:anything)
    end

    it "should evaluate the block against the given object" do
      threepwood = Badge.new do |user|
        user.name == "threepwood"
      end

      threepwood.should be_applicable_to(stub(:name => "threepwood"))
      threepwood.should_not be_applicable_to(stub(:name => "lechuck"))
    end
  end

  context "badges" do
    before(:each) { Badge.clear_badges! }

    it "should add the given badge to the list of badges" do
      Badge.should_not have_badge("a badge")
      Badge.add(:name => "a badge") {}
      Badge.should have_badge("a badge")
      Badge.all.size.should == 1
    end

    it "should be able to clear the list of badges" do
      Badge.add(:name => "a badge") {}
      Badge.clear_badges!
      Badge.all.should be_empty
    end

    it "should be able to filter a list of badges applicable to a user" do
      happy  = Badge.add { |u| u.happy? }
      yellow = Badge.add { |u| u.color =~ /yellow/ }
      green  = Badge.add { |u| u.color =~ /green/ }

      Badge.filter(stub(:happy? => true, :color => "red")).should == [ happy ]
      Badge.filter(stub(:happy? => false, :color => "yellow-green")).should == [ yellow, green ]
      Badge.filter(stub(:happy? => false, :color => "blue")).should be_empty
    end
  end
end
