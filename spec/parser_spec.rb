require 'rspec'
require './bnfkr.rb'

describe Parser do
  describe "#read" do
    it "should strip out any non-bf instructions"
    it "should return an array of one character instructions"
  end

  describe "#exec" do

  end

  describe "#normalize" do
    it "should keep the pointer within the array"
    it "should keep each cell within its limit"

  end

  describe "#reset" do
    it "should set all values of array to 0"
    it "should set all pointers to 0"
    it "should set loop stack and operators list to empty arrays"
  end
end
