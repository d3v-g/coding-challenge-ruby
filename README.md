# Coding Challenge

## Solution Setup and Run Instructions

Install gems:

```
bundle install
```

Run tests:

```
bundle exec ruby test/run_tests.rb
```

Run using irb:

```
bundle exec irb -I lib -r ./lib/currency_exchange.rb
```

```
CurrencyExchange.rate(Date.new(2018, 11, 22), "USD", "GBP") 
# output: 0.7769709725510829
```

## Design Decisions

### Assumptions
- Please note that I am new to Ruby and its syntax.
- Future source data shape will be the same as the provided json data file, i.e. a top level field of dates and lower level field of currencies. If future sources of data have different shapes, there will be a requirement to normalise the data into the same shape.

### Solution steps
1. Normalise arguments by stripping whitespace and converting any lower case letters to upper case.
2. Retrieve currency data from [repository](#repository-pattern)
3. Validate data
   1. Validate arguments, i.e. date and currencies. If no rates are found, the programme will raise an exception.
   2. `self.validate_rates` leverages the `GetRates` module
4. Find currency rates by using the `GetRates` module to find currency rates
5. Return calculated rate

### Repository pattern
I wrote my solution with the separation of concerns in mind. Having separation of concerns helps our code to be reusable, testible and easier for future scaling. Therefore, I have implemented a [repository pattern](/lib/repository). Using repository pattern separates business logic from data access logic, which allows our project to have a single place for retrieving source data. As opposed to hard-coded dependencies, this pattern will help us implement different data sources with ease, and with no effect on business logic implementation.

The base repository class methods will never be called, but instead uses inheritance, enabling it to act as an interface to the different implementations, i.e. [JsonRepository](/lib/repository/json_repository.rb) and [RdbmsRepository]((/lib/repository/rdbms_repository.rb)).

### Strategy pattern
To further enable dealing with different data sources, I opted for a strategy pattern to decide which repository should be in use. This pattern also gives great flexibility for adding more repositories in the future, as we will only need to add it in one place.

### Configuration
I have created a [currency config module](/lib/config/currency_config.rb) to configure variables that will need to change throughout. The module makes use of environment variables, which means we can change configuration from outside of the app, without having to change the code. We can change our configuration at runtime for testing different source data with different base currency.

If no environment variables are provided, the configuration will have defaults set for our variables. E.g. `BASE_CURRENCY = ENV.has_key?('BASE_CURRENCY') ? ENV['BASE_CURRENCY'] : "EUR"`. Example rdbms data configuration is also provided.

### [GetRates](/lib/get_rates.rb) and [FileHandler](/lib/file_handler.rb) modules
Two functional modules that are individually tested and can be reused.

### Tests
I have written additional test cases to cover the various logical flows and exceptions. I also aimed to define test cases in an easy-to-understand manner for easy debugging, e.g. `test_rate_method_returns_correct_rate_for_non_base_currency`. Note that all tests are written on the basis of euro being the base currency.

### Gemfile.lock:

Upgraded to Bundle version 2.4.1 as I was getting error message when using Ruby 3.2.0 with Bundler 2.0.1: bundle exec irb undefined method `untaint' for :String (NoMethodError). After some research, I found that untaint was no longer supported in Ruby 3.2.0: https://bugs.ruby-lang.org/issues/16131. Therefore I upgraded Bundle to the latest version to resolve this error.