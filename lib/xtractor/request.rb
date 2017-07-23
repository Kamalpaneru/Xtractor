require 'net/http'

def request_API
  #@directory = File.expand_path("cell-files",File.dirname(__FILE__))
  uri = URI('https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr')
  uri.query = URI.encode_www_form({

    'language' => 'unk',
    'detectOrientation ' => 'true'
  })

  request = Net::HTTP::Post.new(uri.request_uri)

  request['Content-Type'] = 'application/octet-stream'

  request['Ocp-Apim-Subscription-Key'] = "664a0b22b4014e2d916b9fc6a05b5fe6"



    json_file = File.open('json_data.tsv','w')

  Dir.glob("cell-files/*.{jpg,png,gif}") do |crop_image|
    request.body = File.binread("#{crop_image}")

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    json_file.puts(response.body)

  end
   json_file.close
end







