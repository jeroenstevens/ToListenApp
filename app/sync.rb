class Sync
  URL = 'http://localhost:3000/api/artists.json'
  URL_J = 'http://localhost:3000/api/artists'

  def get
    BW::HTTP.get(URL) do |response|
      @data = BW::JSON.parse(response.body.to_s)
      result
    end
  end

  def post(artist_name)
    data = { artist: { name: artist_name, listened: false } }
    BW::HTTP.post(URL_J, {payload: data}) do |response|
      @data = BW::JSON.parse(response.body.to_s)
      p @data
    end
  end

  def result
    p @data
    @data.each do |i|
      p i['name']
    end
  end
end