namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando Banco de Dados...") {%x(rails db:drop)}
      show_spinner("Criando Banco de Dados...") {%x(rails db:create)}
      show_spinner("Migrando Banco de Dados...") { %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
        coins = [
                  {
                      description: "Bitcoin",
                      acronym: "BTC",
                      url_image: "https://e7.pngegg.com/pngimages/548/763/png-clipart-bitcoin-bitcoin-thumbnail.png",
                      mining_type: MiningType.find_by(acronym: 'PoW')
                  },
                  {
                      description: "Ethereum",
                      acronym: "ETH",
                      url_image: "https://png.pngtree.com/png-vector/20210427/ourmid/pngtree-ethereum-cryptocurrency-coin-icon-png-image_3246438.jpg",
                      mining_type: MiningType.all.sample
                  },
                  {
                      description: "Dash",
                      acronym: "DASH",
                      url_image: "https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png",
                      mining_type: MiningType.all.sample
                  },
                  {
                      description: "Iota",
                      acronym: "IOT",
                      url_image: "https://w7.pngwing.com/pngs/486/784/png-transparent-iota-cryptocurrency-wallet-cryptocurrency-wallet-bitfinex-coin-design-emblem-label-exchange.png",
                      mining_type: MiningType.all.sample
                  },
                  {
                      description: "ZCash",
                      acronym: "ZEC",
                      url_image: "https://w7.pngwing.com/pngs/401/234/png-transparent-zcash-crypto-zcash-symbol-zcash-coin-zcash-sign-zcash-logo-zcash-3d-icon-thumbnail.png",
                      mining_type: MiningType.all.sample
                  }
        ]

        coins.each do |coin|
          Coin.find_or_create_by!(coin)
        end
    end
  end

  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"},
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
