# Imba::Rails

Rails integration for the [Imba](https://github.com/somebee/imba) language.

## Usage

Write `.imba` files:

```imba
# in app/assets/javascripts/todo.imba
tag #app
    def awaken
        render
        self

    def render
        <self>
            <h1> "Hello Imba!"

def window.app
    #app
```

Include them together with the Imba runtime in application.js:

```javascript
//= require imba
//= require todo
```

Make it all happen in the view:

```erb
<%= javascript_include_tag 'application' %>
...
<div id="app"></div>
<script>app()</script>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imba-rails'

# You should also depend on a specific version of Imba:
gem 'imab-source', '~> 0.12.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imba-rails

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/judofyr/imba-rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

