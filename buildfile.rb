# This is an example for a build configuration

build = Build.new

# Everything below is optional

# 1. CSS actions
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
css = build.minify('css', css, css_file)

# 2. Base64 encodings
cat = build.to_base64('src/cat.png')
build.from_base64(cat, 'min/cat-new.png')

# 3. HTML actions
html_file = 'src/index.src.html'
html = build.read(html_file)
html = build.replace(
  html,
  {
    '@css'              => css,
    '@buildinfo'        => Time.now.strftime("%d/%m/%Y %H:%M"),
    '@hello'            => 'Meow!',
    '@cat'              => 'data:image/png;base64,' + cat,
    '<!-- @header -->'  => build.read('src/header.src.html'),
    '<!-- @footer -->'  => build.read('src/footer.src.html')
  }
)
html = build.tidy('html', html)
build.minify('html', html, 'min/index.min.html')

# 4. Shell commands
# system('fortune');

content = build.read('http://sugarman.tv')
content = build.minify('html', content)
build.write('sugarman.html', content)



