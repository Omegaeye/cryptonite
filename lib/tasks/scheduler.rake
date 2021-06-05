desc "This task is called by the Heroku scheduler add-on"
task :update_database=> :environment do
  puts "Updating database..."
  Coin.destroy_all
  CoinsFacade.seed_db_crypto_market_info
  puts "done."
end