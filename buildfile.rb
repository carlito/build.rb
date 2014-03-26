# This is an example for a build configuration

build = Build.new;

# Everything below is optional

# Some CSS actions
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
    '$red'  => '#ff0000'
  }
)
#build.write(css_file, css)
css = build.minify('css', css, css_file)

# Some HTML actions
html_file = 'src/index.src.html'
html = build.read(html_file)
html = build.replace(
  html,
  {
    '@css'       => css,
    '@buildinfo' => Time.now.strftime("%d/%m/%Y %H:%M"),
    '@hello'     => 'Hello world!'
  }
)
build.minify('html', html, 'min/index.html')


# system('fortune');
