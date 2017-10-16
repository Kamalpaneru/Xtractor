# Xtractor
<img src="https://badge.fury.io/rb/xtractor.svg" alt="Gem Version" /> <img src="https://travis-ci.org/Kamalpaneru/Xtractor.svg?branch=master" alt="Build" />


Xtractor was developed as a need to the problem of inserting data from an excelsheet image to excel.And it does the same as described.

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
  NOTE: I've replaced Tesseract with Azure Computer Vision API(Not perfect but a significant improvement though).<br> <br>

  ```ruby
    require 'xtractor'

    Xtractor::Execute.new('Image_Filename')

  ```
## Sample Image

![image_f3](https://user-images.githubusercontent.com/13826932/31273813-03dde45a-aab0-11e7-942f-c77202f996d1.jpg)

## Generate API key
  Replace API_KEY in ```lib/xtractor/request.rb ``` with your Key.<br>
    ```https://azure.microsoft.com/en-gb/try/cognitive-services/ ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Kamalpaneru/Xtractor-Gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xtractor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Kamalpaneru/Xtractor-Gem/blob/master/CODE_OF_CONDUCT.md).
