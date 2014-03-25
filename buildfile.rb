build = Build.new;

# CSS
css_file = 'min/style.min.css'
build.merge(
  [
    'src/style-1.css',
    'src/style-2.css',
    'src/style-3.css'
  ],
  css_file
)
css = build.read(css_file)
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
build.write(css_file, css)

# HTML
html_file = 'src/index.src.html'
html = build.read(html_file)
html = build.replace(html, {'css' => css, 'buildinfo'=>Time.now.strftime("%d/%m/%Y %H:%M")});
html = build.minify('html', html)
build.write('min/index.html', html)

# system('fortune');
