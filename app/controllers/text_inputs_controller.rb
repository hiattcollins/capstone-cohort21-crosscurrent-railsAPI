class TextInputsController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @text_inputs = TextInput.all
    render json: @text_inputs
  end

  def show
    # @to_print = Watson.new
    # render :json @to_print
  end

  def create

    @text_input = TextInput.new(text_input_params)
    @text_input.save

    # if @text_input.save
    #     render json: @text_input, status: :created, location: @text_input
    #   else
    #     render json: @text_input.errors, staus: :unprocessable_entity
    # end

    # @test_text = "It is said that passion makes one think in a circle. Certainly with hideous iteration the bitten lips of Dorian Gray shaped and reshaped those subtle words that dealt with soul and sense, till he had found in them the full expression, as it were, of his mood, and justified, by intellectual approval, passions that without such justification would still have dominated his temper. From cell to cell of his brain crept the one thought; and the wild desire to live, most terrible of all man's appetites, quickened into force each trembling nerve and fibre. Ugliness that had once been hateful to him because it made things real, became dear to him now for that very reason. Ugliness was the one reality. The coarse brawl, the loathsome den, the crude violence of disordered life, the very vileness of thief and outcast, were more vivid, in their intense actuality of impression, than all the gracious shapes of art, the dreamy shadows of song. They were what he needed for forgetfulness. In three days he would be free."

    # @text_input_for_db = TextInput.new(text_input_params)

    # if @text_input_for_db
    #     render json: @text_input_for_db, status: :created, location: @text_input_for_db
    #   else
    #     render json: @text_input_for_db, staus: :unprocessable_entity
    # end

    incoming_params = text_input_params
    # # render html: incoming_params
    # # parsed_params = JSON.parse(incoming_params)
    # # render json: parsed_params
    test_text = incoming_params["input_text"]
    # # render html: test_text
    # # render json: test_text


    @test_results = Watson.watson_query(test_text)
    @sentiment = @test_results["emotion"]["document"]["emotion"]
    render json: @sentiment
  end

  private

    def set_text_input
      @text_input = TextInput.find(params[:id])
    end

    def text_input_params
      params.require(:text_input).permit(:query_id, :input_text)
    end

end
