require "rubygems"
require "redis"
$redis = Redis.new(:host => "localhost", :port => 6380)