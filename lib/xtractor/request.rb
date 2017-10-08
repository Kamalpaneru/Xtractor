require 'net/http'
require 'json'

class Azure_API

  extend Xtractor

  def request_API
    uri = URI('https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr')
    uri.query = URI.encode_www_form({

      'language' => 'en',
      'detectOrientation ' => 'true'

    })

  request['Ocp-Apim-Subscription-Key'] = "API_KEY"

    request = Net::HTTP::Post.new(uri.request_uri)

    request['Content-Type'] = 'application/octet-stream'


    collect = Hash.new

      all_files = Dir.glob("cell-files/*.{jpg,png,gif}").sort

      all_files.each do |crop_image|
        request.body = File.binread("#{crop_image}")

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
        end

        collect[crop_image[0..-5]]= JSON.parse(response.body)

        initial_res = collect[crop_image[0..-5]].dig("regions",0,"lines",0,"words",0,"text").to_s
        mid_res = collect[crop_image[0..-5]].dig("regions",0,"lines",0,"words",1,"text").to_s
        final_res = collect[crop_image[0..-5]].dig("regions",0,"lines",0,"words",2,"text").to_s

        collect[crop_image[0..-5]] = initial_res + ' ' + mid_res + ' ' + final_res

        puts collect[crop_image[0..-5]]

        File.open("cell-files/#{crop_image[11..-5]}.txt", "w") do |data|
            data.write(collect[crop_image[0..-5]])
            end
      end
    end

def  out_final(img)
      text_row = []
      output_file = File.open('table.tsv', 'w')
      rows_filter(img)[0..-2].each_with_index do |row, i|
          columns_filter(img)[0..-2].each_with_index do |column, j|
              text_row << File.open("cell-files/#{j}x#{i}.txt", 'r').readlines.map{|line| line.strip}.join(" ")
          end
          output_file.puts( text_row.join("\t"))
      end
      output_file.close
    end
end











