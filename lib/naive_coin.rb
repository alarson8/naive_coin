require 'active_support'
require 'active_support/core_ext/numeric'
# requires all naive_coin/lib/naive_coin files
Dir["#{__dir__}/naive_coin/*.rb"].each {|file| require file}
