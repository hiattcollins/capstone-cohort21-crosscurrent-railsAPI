require 'watson-api-client'

# @test_text = "It is said that passion makes one think in a circle. Certainly with hideous iteration the bitten lips of Dorian Gray shaped and reshaped those subtle words that dealt with soul and sense, till he had found in them the full expression, as it were, of his mood, and justified, by intellectual approval, passions that without such justification would still have dominated his temper. From cell to cell of his brain crept the one thought; and the wild desire to live, most terrible of all man's appetites, quickened into force each trembling nerve and fibre. Ugliness that had once been hateful to him because it made things real, became dear to him now for that very reason. Ugliness was the one reality. The coarse brawl, the loathsome den, the crude violence of disordered life, the very vileness of thief and outcast, were more vivid, in their intense actuality of impression, than all the gracious shapes of art, the dreamy shadows of song. They were what he needed for forgetfulness. In three days he would be free."

#######  watson-api-client function

class Watson

  def self.watson_query(input_text)
    service = WatsonAPIClient::NaturalLanguageUnderstanding.new(
      :version=>"2017-02-27",
      :user=>ENV['WATSON_USERNAME'],
      :password=>ENV['WATSON_PASSWORD'])

    result = service.analyzeGet(
      :version=>"2017-02-27",
      :features=>"emotion",
      :text=>input_text)

    # :notice => "watson triggered"

    JSON.parse(result.body)
    # @watson_result = "test"
  end

end
