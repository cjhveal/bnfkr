class Parser
  attr_reader :array, :pointer, :loop_stack, :op_pointer, :ops

  ARRAY_SIZE = 30000
  ELEMENT_SIZE = 255;

  def initialize
    @operators = {"+" => lambda { @array[@pointer] += 1 }, "-" => lambda { @array[@pointer] -= 1 },
                  ">" => lambda { @pointer += 1 }, "<" => lambda { @pointer -= 1 },
                  "[" => lambda { @loop_stack.push @op_pointer },
                  "]" => lambda { @array[@pointer] == 0 ? (raise "unmatched ]" unless @loop_stack.pop) : @op_pointer = @loop_stack.last },
                  "." => lambda { print @array[@pointer].chr }, "," => lambda { @array[@pointer] = STDIN.getc.ord } }
    @array = Array.new ARRAY_SIZE
    reset
  end

  # parse program, stripping out everything but BF instructions and splitting by charater
  def read program
    program.tr('^+\-<>[],.', '').split(//)
  end

  # excecute a list of instruction, iterating through and calling each
  def exec ops = []
    reset
    @ops = ops
    until @op_pointer == @ops.length
      instruction = @ops[@op_pointer]
      raise "No such instruction '#{instruction}'" unless @operators.include? instruction
      @operators[instruction].call
      normalize
      @op_pointer += 1
    end
    raise "unclosed [" unless @loop_stack.empty?
  end

  # parse and execute a BF program
  def run program
    exec read program
  end

  protected
  # keep everything within bounds
  def normalize
    @pointer %= ARRAY_SIZE
    @array[@pointer] %= ELEMENT_SIZE
  end

  def reset
    @array.map! { |x| 0 }
    @pointer = @op_pointer = 0
    @loop_stack = @ops = []
  end
end
