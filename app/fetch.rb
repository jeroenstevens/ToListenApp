class Fetch
  lastfm_api_endpoint = "http://ws.audioscrobbler.com/2.0/?api_key=f90b2e1d432ddfeee9b30524aeedd6d7&format=json"
  method = "chart.gettopartists"
  URL = lastfm_api_endpoint + "&method=" + method

  def self.top_artists(delegate)
    BW::HTTP.get(URL) do |response|
      data = BW::JSON.parse(response.body.to_s)
      delegate.load_data(data)
      delegate.collectionView.reloadData
    end
  end
end