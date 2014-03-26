
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
    output = input
    replacements.each do|key, value|
      output = output.gsub("#{key}", value.to_s)
    end
    num = replacements.count
    puts '- ' + num.to_s + ' replacement(s) done'
    return output
  end

  def minify(type, input, file = nil)
    # Minify based on type
    case type
      when 'css'
        require 'yui/compressor'
        compressor = YUI::CssCompressor.new
        output = compressor.compress(input)
      when 'html'
        puts '- HTML minify not implemented now'
        output = input
    end

    # Output based on file argument
    if file.nil?
      puts '- Minified'
    else
      puts '- Minified to file ' + file
      write(file, output)
    end
    return output
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
