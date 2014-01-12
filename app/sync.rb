class Sync
  #URL = 'http://http://still-cove-3425.herokuapp.com/api/artists'

  URL = 'http://localhost:3000/api/artists.json'
  #attr_accessor :data

  def self.get(delegate)
    BW::HTTP.get(URL) do |response|
      data = BW::JSON.parse(response.body.to_s)
      delegate.load_data(data)
      delegate.view.reloadData
    end
  end

  def post(artist_name)
    data = { artist: { name: artist_name, listened: false } }
    BW::HTTP.post(URL, {payload: data}) do |response|
      @data = BW::JSON.parse(response.body.to_s)
    end
  end
end