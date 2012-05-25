class Parser
  attr_reader :array, :pointer, :loop_stack, :op_pointer, :ops

  def initialize
    @operators = {"+" => lambda { @array[@pointer] += 1 }, "-" => lambda { @array[@pointer] -= 1 },
                  ">" => lambda { @pointer += 1 }, "<" => lambda { @pointer -= 1 },
                  "[" => lambda { @loop_stack.push @op_pointer }, "]" => lambda { @array[@pointer] == 0 ? @loop_stack.pop : @op_pointer = @loop_stack.last },
                  "." => lambda { print @array[@pointer].chr }, "," => lambda { getc } }
    @array = Array.new 30000
    reset
  end


  def read program
    program.tr('^+\-<>[],.', '').split(//)
  end

  def exec ops = []
    reset
    @ops = ops
    until @op_pointer == @ops.length
      instruction = @ops[@op_pointer]
      @operators[instruction].call
      @op_pointer += 1
    end
  end

  def run program
    exec read program
  end

  protected
  def getc
    begin
      system("stty raw -echo")
      STDIN.getc
    ensure
      system("stty -raw echo")
    end
  end

  def reset
    @array.map! { |x| 0 }
    @pointer = @op_pointer = 0
    @loop_stack = @ops = []
  end
end
