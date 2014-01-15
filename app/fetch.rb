class Fetch
  lastfm_api_endpoint = "http://ws.audioscrobbler.com/2.0/?api_key=f90b2e1d432ddfeee9b30524aeedd6d7&format=json"
  # Methods
  @top_artists = "chart.gettopartists"
  @random_artist_by_user_name = "library.getartists&user="
  # Base URL
  URL = lastfm_api_endpoint + "&method="

  def self.top_artists(delegate)
    BW::HTTP.get(URL+@top_artists) do |response|
      data = BW::JSON.parse(response.body.to_s)
      delegate.load_data(data)
      delegate.collectionView.reloadData
    end
  end

  def self.random_artist_by_user_name(delegate, user_name)
    BW::HTTP.get(URL+@random_artist_by_user_name+user_name) do |response|
      data = BW::JSON.parse(response.body.to_s)
      delegate.load_data(data)
      delegate.collectionView.reloadData
    end
  end
end