require "xtractor/version"
require "rubygems"
require "rmagick"

module Xtractor
  class Execute
    def initialize(image)
      img = Magick::Image::read(image).first
      img = img.resize_to_fit(2500,906)
      box = img.bounding_box
      img.crop!(box.x, box.y, box.width, box.height)
      img.write('test.tif')
    end
  end
end
