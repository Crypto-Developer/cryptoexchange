require 'spec_helper'

RSpec.describe 'Ccx integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('ccx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ccx'
  end

  it 'give trade url' do
    btc_usdt_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usdt', market: 'ccx')
    trade_page_url = client.trade_page_url 'ccx', base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq "https://ccxcanada.com/markets/btcusdt"
  end

  it 'fetch ticker' do
    btc_usdt_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usdt', market: 'ccx')
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'ccx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

end
