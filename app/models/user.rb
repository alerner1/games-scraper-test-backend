class User < ApplicationRecord
  attr_encrypted :access_token, key: Rails.application.credentials.tokens[:access_token_key]

  # shows i can access the rawg api
  def self.access_rawg
    api_key = Rails.application.credentials.api_keys[:rawg_key]
    response = HTTParty.get("https://api.rawg.io/api/games?key=#{api_key}&dates=2019-09-01,2019-09-30&platforms=18,1,7", :headers => {"User-Agent" => "What To Play Next"})
     
    parsed_data = JSON.parse response.body
  end

  # shows i can access the steam api (this particular method gets a list of games they own)
  def self.access_steam
    api_key = Rails.application.credentials.api_keys[:steam_key]
    response = HTTParty.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{api_key}&steamid=76561198068257125&format-json")
    parsed_data = JSON.parse response.body
    byebug
  end

  # shows i can get the steam id for whatever username they put in
  # no oauth required here, this info is public
  def self.get_steam_id
    # in the actual project, this will be an instance method based on the user's steam name, which will itself be an attribute of the User model. 
    steam_name = "witchesofus"
    response = HTTParty.get("https://steamidfinder.com/lookup/#{steam_name}")
    parsed_data = Nokogiri::HTML.parse(response)
    steam_id = parsed_data.css('.panel-body').children[9].children.text
    byebug
  end
end

# next steps: for mvp, get metadata from rawg for games they own but haven't played yet
# get metadata from rawg for games they played the longest, store genres and tags and publishers etc as qualities they liked
# of the games they haven't played yet, which are they most likely to enjoy?

# THEN: expand to include other games on platforms of their choosing. could filter by genres and tags and creators etc that we want so we don't get ALL GAMES EVER.

# THEN: allow user to choose genre they're in the mood for and factor that in

# etc etc