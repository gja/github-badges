require 'spec_helper'

describe "Foo" do
  it "should bang" do
    lambda { raise("bang!") }.should raise_error("bang!")
  end
end