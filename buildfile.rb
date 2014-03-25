build = Build.new;

css_file = 'min/style.min.css'
build.merge(
  [
    'src/style-1.css',
    'src/style-2.css',
    'src/style-3.css'
  ],
  css_file
)
css = File.read(css_file)
css = build.replace(
  css,
  {
    'blue' => '#ff00cc',
    'green' => '#0099ff',
    'pink' => '#ff0000',
    'one' => 'hm'
  }
);
css = build.minify('css', css)
build.write_file(css_file, css)



html_file = 'src/index.src.html'
html = File.read(html_file)
html = build.replace(html, {'css' => css});
html = build.minify('html', html)
build.write_file('min/index.html', html);


# system('fortune');
