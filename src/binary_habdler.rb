require_relative './handler'

class BinaryHandler < Handler
  attr_reader :translator, :recorder, :command_type, :symbol, :dest, :comp, :jump

  def initialize(translator, recorder)
    @translator = translator
    @recorder = recorder
  end

  def parse(current_command, line_num)
    if (m = a_command?(current_command))
      parse_a(m[1])
    elsif (m = l_command?(current_command))
      parse_l(m[1])
    elsif (m = c_full_command?(current_command))
      parse_c(dest: m[1], comp: m[2], jump: m[3])
    elsif (m = c_no_jump_command?(current_command))
      parse_c(dest: m[1], comp: m[2], jump: nil)
    elsif (m = c_only_jump_command?(current_command))
      parse_c(dest: nil, comp: m[1], jump: m[2])
    else
      raise InvalidCommandError, "#{current_command} does not match any types of command"
    end
  end

  private

  COMMAND_TYPE = {a_command: :A_COMMAND, c_command: :C_COMMAND, l_command: :L_COMMAND}

  def parse_a(symbol)
    @command_type = COMMAND_TYPE[:a_command]
    @symbol = translator.translate_symbol(symbol)

    register_a_binary
  end

  def parse_l(symbol)
    @command_type = COMMAND_TYPE[:l_command]
    @symbol = translator.translate_symbol(symbol)

    nil
  end

  def parse_c(dest:, comp:, jump:)
    @command_type = COMMAND_TYPE[:c_command]

    @dest = translator.translate_dest(dest)
    @comp = translator.translate_comp(comp)
    @jump = translator.translate_jump(jump)

    register_c_binary
  end

  def register_a_binary
    recorder.register('0' + symbol)
  end

  def register_c_binary
    recorder.register('111' + comp + dest + jump)
  end

end

class InvalidCommandError < StandardError; end
