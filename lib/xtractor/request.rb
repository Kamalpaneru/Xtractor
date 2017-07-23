require 'net/http'

def request_API
  @directory = File.expand_path("cell-files",File.dirname(__FILE__))
  uri = URI('https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr')
  uri.query = URI.encode_www_form({

    'language' => 'unk',
    'detectOrientation ' => 'true'
  })

  request = Net::HTTP::Post.new(uri.request_uri)

  request['Content-Type'] = 'application/octet-stream'

  request['Ocp-Apim-Subscription-Key'] = '43f80a0ab4d5441d8e0d292e19e5d3c9'


  Dir.glob("#{@directory}/*.{jpg.png.gif}") do |crop_image|
    request.body = File.binread(crop_image)

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    json_file = File.open('json_data.tsv','w')

    json_file.puts(response.body)

    json_file.close
  end
end





