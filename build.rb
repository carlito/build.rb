
class Build

  def merge(input_files, output_file)
    # Read files
    output = ''
    input_files.each do|file|
      file = File.read("#{file}")
      output += file
    end
    # Write file
    write_file(output_file, output)
  end

  def replace(input, replacements)
    output = ''
    suffix = '##';
    replacements.each do|key, value|
      variable = suffix + key
      output = input.gsub("#{variable}", value.to_s)
    end
    return output
  end

  def minify(type, input)
    case type
      when 'css'
        require 'yui/compressor'
        compressor = YUI::CssCompressor.new
        return compressor.compress(input)
      when 'html'

    end
  end

  def write_file(file, content)
    File.open(file,'w') do |output_file|
      output_file.puts content
    end
  end

end

require_relative 'buildfile'
