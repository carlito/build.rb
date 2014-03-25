
class Build

  def merge(input_files, output_file)
    # Read files
    output = ''
    input_files.each do|file|
      file = File.read("#{file}")
      output += file
    end
    # Write file
    write(output_file, output)
  end

  def replace(input, replacements)
    output = ''
    suffix = '##';
    replacements.each do|key, value|
      variable = suffix + key
      output = input.gsub("#{variable}", value.to_s)
    end
    num = replacements.count
    puts '- ' + num.to_s + ' replacement(s) done'
    return output
  end

  def minify(type, input)
    case type
      when 'css'
        require 'yui/compressor'
        compressor = YUI::CssCompressor.new
        return compressor.compress(input)
      when 'html'
        puts '- HTML minify not implemented now'
        return input
    end
  end

  def read(file)
    return File.read(file)
  end

  def write(file, content)
    File.open(file,'w') do |output_file|
      puts '- File \'' + file + '\' written'
      output_file.puts content
    end
  end

end

require_relative 'buildfile'
