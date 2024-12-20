class WelcomeController < ApplicationController
  def index
    @meu_nome = params[:nome]
    @curso = "Rails"
  end
end
