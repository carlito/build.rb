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
    '$pink' => '#ff00cc',
    '$blue' => '#0099ff',
    '$red' => '#ff0000',
    'one' => 'eins'
  }
)
#build.write(css_file, css)
css = build.minify('css', css, css_file)

# HTML
html_file = 'src/index.src.html'
html = build.read(html_file)
html = build.replace(
  html,
  {
    '@css' => css,
    '@buildinfo' => Time.now.strftime("%d/%m/%Y %H:%M"),
    'title'=>'titel', 'head'=>'kopf', 'footer'=>'fuss'
  }
)
build.minify('html', html, 'min/index.html')

#build.replace2(html, {'title'=>'fubar', 'head'=>'kopf', 'footer'=>'fuss'})


# system('fortune');
