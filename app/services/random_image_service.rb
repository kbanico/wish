class RandomImageService
  def self.random_image_url
    res = Net::HTTP.get_response(URI('https://source.unsplash.com/random'))
    $req = res['location']
  end
end
