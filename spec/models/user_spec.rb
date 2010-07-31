require 'spec_helper'

describe User do
  it "should be able to get all languages from a user's public repos" do
    repo1 = stub(:languages => {"Ruby" => 100, "C++" => 10}, :fork => false)
    repo2 = stub(:languages => {"Ruby" => 100, "F#" => 100}, :fork => false)
    repo3 = stub(:languages => {"Java" => 100, "AnotherNonIncludedLanguage" => 100}, :fork => true)

    languages = User.new(stub(:repositories => [ repo1, repo2, repo3 ])).languages

    languages.length.should == 3
    languages.should include "Ruby"
    languages.should include "C++"
    languages.should include "F#"
  end

  it "should be able to get a map of languages to number of lines of code" do
    repo1 = stub(:languages => {"Ruby" => 100, "C++" => 10}, :fork => false)
    repo2 = stub(:languages => {"Ruby" => 100, "F#" => 100}, :fork => false)
    repo3 = stub(:languages => {"Ruby" => 100, "AnotherNonIncludedLanguage" => 100}, :fork => true)

    languages = User.new(stub(:repositories => [ repo1, repo2, repo3 ])).languages

    languages["Ruby"].should == 200
  end

  it "should be able to get a list of empty repositories" do
    repo1 = stub(:commits => [])
    repo2 = stub(:commits => [stub, stub])
    repo3 = stub(:commits => [stub])

    user = User.new(stub(:repositories => [repo1, repo2, repo3]))
    empty_repos = user.empty_repositories

    user.empty_repositories_count.should == 1
    empty_repos.should include repo1
  end
end
