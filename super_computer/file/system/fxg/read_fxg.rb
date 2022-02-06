def execute(path, *args)
  puts args
  currentdir = `pwd`
  load "#{currentdir.gsub("\n","")}/file/system/fxg/fxg_vars.rb"
  steps = [""]
  file = File.open(path)
  input = file.readline
  file.close
  comment = false
  input.gsub('=>', ':').each_char do |letter|
    if comment == false
      if letter == ":"
        steps[steps.length] = ""
      elsif letter == ","
        steps[steps.length-1] += ","
        steps[steps.length] = ""
      elsif letter == "#"
        comment = true
        steps[steps.length-1] += "#"
      else
        steps[steps.length-1] += letter
      end
    elsif comment == true
      if letter == "#"
        comment = false
        steps[steps.length-1] += "#"
      else
        steps[steps.length-1] += letter
      end
    end
  end

  steps.each do |step|
    if step.start_with?(">")
      steps[steps.index(step)] = steps[steps.index(step)][1..step.length]
    end
  end

  #puts steps

  cx = 0
  condat = []
  while cx < steps.size
    step = steps[cx]
    if step.start_with?("?")
      print "? "
      input = gets.chomp
      step = input + step[1..step.length]
    end
    if step[(step.length-3)..(step.length-2)] == "->"
      eval("#{step[step.length-1].lowercase} = #{step[0...step.length-3].lowercase}")
    end
    if step.start_with?("g")
      if steps.include?("l"+(eval(step[1])).to_s)
        cx = steps.index("l"+(eval(step[1])).to_s)-1
      end
    else
      conditional = false
      $list_of_symbols.each do |symbol|
        if step.include?(symbol)
          conditional = true
        end
      end
      if (/[A-Z]>[A-Z]/ =~ step) != nil
        conditional = true
      end

      if conditional
        unless eval(step.lowercase)
          cx += 1
          conditionaltrue = 0
        else
          conditionaltrue = 1
          condat.push(cx)
        end
      elsif step.end_with?(",")
        puts(eval(step[0...step.length-1].lowercase))
      end
    end
    if conditionaltrue == 2 and condat.include?(cx-1)
      cx += 1
    end
    if conditionaltrue == 1
      conditionaltrue = 2
    end
    steps[cx] = step
    cx += 1
  end
end
