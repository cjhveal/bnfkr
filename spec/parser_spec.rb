require 'rspec'
require './bnfkr.rb'

describe Parser do
  before(:all) do
    @parser = Parser.new
  end

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
    before(:all) do
      @parser.send :reset
    end

    it "should set all values of array to 0" do
      @parser.array.all? {|x| x == 0}.should be_true
    end

    it "should set all pointers to 0" do
      @parser.pointer.should eq 0
      @parser.op_pointer.should eq 0
    end

    it "should set loop stack and instructions list to empty arrays" do
      @parser.loop_stack.empty?.should be_true
      @parser.ops.empty?.should be_true
    end
  end
end
