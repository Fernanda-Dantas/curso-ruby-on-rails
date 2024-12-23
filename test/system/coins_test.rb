require "application_system_test_case"

class CoinsTest < ApplicationSystemTestCase
  setup do
    @coin = coins(:one)
  end

  test "visiting the index" do
    visit coins_url
    assert_selector "h1", text: "Coins"
  end

  test "should create coin" do
    visit coins_url
    click_on "Nova moeda"

    fill_in "Acronym", with: @coin.acronym
    fill_in "Description", with: @coin.description
    fill_in "Url image", with: @coin.url_image
    click_on "Create Coin"

    assert_text "Coin was successfully created"
    click_on "Voltar"
  end

  test "should update Coin" do
    visit coin_url(@coin)
    click_on "Edit this coin", match: :first

    fill_in "Acronym", with: @coin.acronym
    fill_in "Description", with: @coin.description
    fill_in "Url image", with: @coin.url_image
    click_on "Update Coin"

    assert_text "Coin was successfully updated"
    click_on "Voltar"
  end

  test "should destroy Coin" do
    visit coin_url(@coin)
    click_on "Apagar moeda", match: :first

    assert_text "Moeda apagada com sucesso"
  end
end
