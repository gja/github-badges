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

  context "category" do
    it "should have a category" do
      Badge.new(:category => "Stuff").category.should == "Stuff"
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
  end

  context "quantifiable?" do
    it "should be true if the target of the badge is a number" do
      Badge.new(:target => 1).should be_quantifiable
    end

    it "should be true if the target of a badge is an array" do
      Badge.new(:target => [1, 2]).should be_quantifiable
    end

    it "should be false if the target of the badge is a Proc" do
      Badge.new(:target => lambda { false }).should_not be_quantifiable
    end

    it "should be false if the target of the badge is a string" do
      Badge.new(:target => "not valid").should_not be_quantifiable
    end
  end

  context "earned_by?" do
    it "should use the given target if it is a proc" do
      Badge.new(:target => lambda { true }).should be_earned_by(stub("User"))
      Badge.new(:target => lambda { false }).should_not be_earned_by(stub("User"))
    end

    it "should be true if the quantity in the given user is greater than or equal to the given target" do
      Badge.new(:target => 1, :measure => :widgets).tap do |badge|
        badge.should_not be_earned_by(stub(:widgets => 0))
        badge.should be_earned_by(stub(:widgets => 1))
        badge.should be_earned_by(stub(:widgets => 10))
      end
    end

    it "should be true if the quantity in the given user is included in the list of possible targets" do
      Badge.new(:target => [1, 2], :measure => :widgets).tap do |badge|
        badge.should_not be_earned_by(stub(:widgets => 0))
        badge.should be_earned_by(stub(:widgets => 1))
        badge.should be_earned_by(stub(:widgets => 2))
        badge.should_not be_earned_by(stub(:widgets => 3))
      end
    end
  end

  context "progress" do
    it "should apply the given measure to the user" do
      Badge.new(:measure => :widgets).progress(stub(:widgets => 10)).should == 10
    end
  end
end
