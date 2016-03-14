require 'minitest'
module Cucumber
  module MiniTestAssertions
    def self.extended(base)
      base.extend(MiniTest::Assertions)
      base.assertions = 0
    end

    attr_accessor :assertions
  end
end
World(Cucumber::MiniTestAssertions)

