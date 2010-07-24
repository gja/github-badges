require 'spec_helper'

require File.dirname(__FILE__) + "/../../app/models/question"

describe Question do
  before(:each) do
    @valid_attributes = {
      :text => "A standard question?",
      :answer => "an answer",
      :latitude => "12.324234343",
      :longitude => "23.23423432",
      :genre_list => "genre1, genre2, genre3"
    }
  end

  it "should create a new instance given valid attributes" do
    Question.find(:all).size.should == 0
    Question.create!(@valid_attributes)
    Question.find(:all).size.should == 1
  end

end
