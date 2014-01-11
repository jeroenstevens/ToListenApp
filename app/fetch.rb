class Fetch
  lastfm_api_endpoint = "http://ws.audioscrobbler.com/2.0/?api_key=f90b2e1d432ddfeee9b30524aeedd6d7&format=json"
  method = "chart.gettopartists"
  URL = lastfm_api_endpoint + "&method=" + method

  def top_artists
    BW::HTTP.get(URL) do |response|
      @data = BW::JSON.parse(response.body.to_s)
      result
    end
  end

  def result
    @data
    # @data[:artists][:artist].each do |artist|
#       p artist[:name]
#     end
  end
end