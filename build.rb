
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

  def minify(type, input, output_file = nil)
    # Minify based on type
    case type
      when 'css'
        require 'yui/compressor'
        compressor = YUI::CssCompressor.new
        output = compressor.compress(input)
      when 'html'
        output = remove_empty_lines(input)
        output = remove_space_between_tags(output)
        output = remove_html_comments(output)
        output = remove_css_comments(output)
    end
    # Output based on file argument
    if output_file.nil?
      puts '- Minified ' + type.upcase
    else
      puts '- Minified ' + type.upcase + ' to file \'' + output_file + '\''
      write(output_file, output)
    end
    # Return
    return output
  end

  def tidy(type, input)
    case type
      when 'html'
        #require 'tidy_ffi'
        #xml = TidyFFI::Tidy.new('').clean
        #output = TidyFFI::Tidy.new(input, :output_xml, true).clean
        #return output
        puts '! Tidy HTML not implemented yet'
        return input
    end
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

  def uri?(string)
    require 'open-uri'
    uri = URI.parse(string)
    # Passes only urls not uris?
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

  def remove_empty_lines(input)
    output = input.gsub(/^$\n/, '')
    return output
  end

  def remove_space_between_tags(input)
    output = input.gsub!(/\n\t/, ' ').gsub!(/>\s*</, '><')
    return output
  end

  def remove_html_comments(input)
    output = input.gsub!(/<!--(.*?)-->/, '')
    return output
  end

  def remove_css_comments(input)
    # Doesn't work
    #output = input.gsub!(\/\*(.*?)\*\/, '')
    output = input
    return output
  end

end

require_relative 'buildfile'
