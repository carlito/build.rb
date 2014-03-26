
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
    # Output Message
    num = input_files.count
    puts '- Merged ' + num.to_s + ' files to \'' + output_file + '\''
  end

  def replace(input, replacements)
    # Replace
    output = input
    replacements.each do|key, value|
      output = output.gsub("#{key}", value.to_s)
    end
    # Output Message
    num = replacements.count
    puts '- Replaced ' + num.to_s + ' string(s)'
    # Return
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
        puts '! HTML minify not implemented now'
        output = input
    end

    # Output based on file argument
    if file.nil?
      puts '- Minified ' + type
    else
      puts '- Minified ' + type + ' to file \'' + file + '\''
      write(file, output)
    end
    # Return
    return output
  end

  def read(target)
    if uri?(target)
      output = read_uri(target)
    else
      output = File.read(target)
    end
    return output
  end

  def write(file, content)
    File.open(file,'w') do |output_file|
      #puts '- File \'' + file + '\' written'
      output_file.puts content
    end
  end

  def read_uri(url)
    if uri?(url)
      file = open(url)
      return file.read
    else
      puts '! No valid URL'
    end
  end

  # Passes only urls not uris?
  def uri?(string)
    require 'open-uri'
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end

  def to_base64(path)
    require 'base64'
    output = Base64.encode64(File.read(path))
    puts '- Encoded image \'' + path + '\' to Base64 string'
    return output
  end

  def from_base64(base64string, file)
    require 'base64'
    basepath = File.dirname(__FILE__)
    output = Base64.decode64(base64string)
    File.open(file, 'wb') do|f|
      f.write(output)
    end
    puts '- Decoded Base64 string to ' + file
  end

end

require_relative 'buildfile'
