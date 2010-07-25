require 'spec_helper'

describe "user helper methods" do
  it "Should be able to get all languages from a user's public repos" do
    repo1 = stub(:languages => {"Ruby" => 100, "C++" => 10}, :fork => false)
    repo2 = stub(:languages => {"Ruby" => 100, "F#" => 100}, :fork => false)
    repo3 = stub(:languages => {"Java" => 100, "AnotherNonIncludedLanguage" => 100}, :fork => true)
    user = stub(:repositories => [repo1, repo2, repo3])

    languages = get_languages_from_non_forked_repos(user)

    languages.length.should == 3
    languages.should include "Ruby"
    languages.should include "C++"
    languages.should include "F#"
  end

  it "should be able to get a map of languages to number of lines of code" do
    repo1 = stub(:languages => {"Ruby" => 100, "C++" => 10}, :fork => false)
    repo2 = stub(:languages => {"Ruby" => 100, "F#" => 100}, :fork => false)
    repo3 = stub(:languages => {"Ruby" => 100, "AnotherNonIncludedLanguage" => 100}, :fork => true)
    user = stub(:repositories => [repo1, repo2, repo3])

    languages = get_languages_from_non_forked_repos(user)

    languages["Ruby"].should == 200
  end

  context "merge maps" do
    it "should be able to merge two maps as the sum of values" do
      first = {"a" => 10}
      second = {"a" => 20, "b" => 10}

      merge_language_maps([first, second]).should == {"a" => 30, "b" => 10}
    end
  end
end
