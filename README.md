# Xtractor
<img src="https://badge.fury.io/rb/xtractor.svg" alt="Gem Version" />

<<<<<<< HEAD
Xtractor was developed as a need to my own problem of inserting  data from an excelsheet image to excel.And it does the same as described.
=======
Xtractor was developed as a need to the problem of inserting data from an excelsheet image to excel.And it does the same as described.
>>>>>>> develop

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xtractor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xtractor

## Usage

Used to split cells from excel sheet images and extracts data. <br>
  NOTE: Tesseract didn't work as smoothly as I imagined it to be.<br> <br>

  ```ruby
    require 'xtractor'

    Xtractor::Execute.new('Image_Filename')

  ```
## Sample Image
![image_final](https://user-images.githubusercontent.com/13826932/27982128-beed0218-63ba-11e7-8a0e-1bd769183e7d.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Kamalpaneru/Xtractor-Gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xtractor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Kamalpaneru/Xtractor-Gem/blob/master/CODE_OF_CONDUCT.md).
