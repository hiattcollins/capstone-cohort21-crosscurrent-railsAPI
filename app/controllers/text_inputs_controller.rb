class TextInputsController < ApplicationController

  def index
    @text_inputs = TextInput.all
    render json: @text_inputs
  end

  def create
    @text_input = TextInput.new(text_input_params)
    @text_input.save
  end

  private

    def set_text_input
      @text_input = TextInput.find(params[:id])
    end

    def text_input_params
      params.require(:text_input).permit(:query_id, :input_text)
    end

end
