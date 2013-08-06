# == Schema Information
#
# Table name: urls
#
#  id  :integer          not null, primary key
#  url :string(255)
#
require 'spec_helper'

describe Url do


  it {should have_many(:events)}



end
