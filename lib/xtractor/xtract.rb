require "rubygems"
require "rmagick"
require_relative "request"

module Xtractor
  class Execute

    @directory = File.expand_path("cell-files", File.dirname(__FILE__))

    def initialize(image)
      img = Magick::Image::read(image).first

      if %w(TIFF).include? img.format
        crop_throw(img)
      else
        img.write('Conv_img.tif')
        img = Magick::Image::read('Conv_img.tif').first
        crop_throw(img)
      end
    end

    def crop_throw(img)
       img = img.resize_to_fit(2500,906)
       box = img.bounding_box
       img.crop!(box.x, box.y, box.width, box.height)
      start(img)
    end

    def store_line_rows(img)
      (0...img.rows).inject([]) do |arr, line_index|
        threshold = (img.columns*0.10).floor
        arr << line_index if img.get_pixels(0, line_index, (threshold), 1).select{|pixel|
          pixel.red < 63000 }.length >= threshold*0.95
        arr
      end
    end

    def store_line_columns(img)
      (0...img.columns).inject([])do |arr, line_index|
        threshold = (img.rows*0.10).floor
        arr << line_index if img.get_pixels(line_index, 0, 1, (threshold)).select{|pixel|
          pixel.red < 63000 }.length >= threshold*0.95
        arr
      end
    end

    def columns_filter(img)
      store_line_columns(img)[1..-1].inject( [[ (store_line_columns(img)[0]),(store_line_columns(img)[0]) ]]) do |arr, line|
        if line == arr.last[1]+1
          arr.last[1] = line
        else
          arr << [line,line]
        end
        arr
      end
    end

    def rows_filter(img)
      store_line_rows(img)[1..-1].inject( [[ (store_line_rows(img)[0]), (store_line_rows(img)[0] )]]) do |arr, line|
        if line == arr.last[1]+1
          arr.last[1] = line
        else
          arr << [line,line]
        end
        arr
      end
    end


    def start(img)
      Dir.mkdir('cell-files') if !File.exists?('cell-files')

      rows_filter(img)[0..-2].each_with_index do |row, i|
        columns_filter(img)[0..-2].each_with_index do |column, j|
          x,y= column[1], row[1]
          w,h= columns_filter(img)[j+1][0]-x, rows_filter(img)[i+1][0]-y

          Magick::Image.constitute(w, h, "RGB", img.get_pixels(x,y,w,h).map{ |pixel|
          [pixel.red, pixel.green, pixel.blue]}.flatten).write("cell-files/#{j}x#{i}.jpg") do |out|
              out.depth=8
          end

           r_image = Magick::Image::read("cell-files/#{j}x#{i}.jpg").first
           res_image = r_image.resize(r_image.columns,100)

           res_image.write("cell-files/#{j}x#{i}.jpg") do
             self.quality = 100
           end

        end
      end
      collect_hash
    end

    def collect_hash
     request_API
    end

  end
end

