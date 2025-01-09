class WelcomeController < ApplicationController
  def index
    # cookies[:curso] = "Curso de Ruby on Rails - Aluna: Fernanda"
    @meu_nome = params[:nome]
    @curso = "Rails"
  end
end
