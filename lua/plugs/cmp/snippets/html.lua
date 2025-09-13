local u = require 'plugs.cmp.snippets.utils'

return {
  -- Basic structure
  u.s(
    'html',
    u.fmt(
      [[
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{}</title>
  </head>
  <body>
    {}
  </body>
  </html>
  ]],
      { u.i(1, 'Document Title'), u.i(2, '') }
    )
  ),

  -- Headings
  u.s('h1', u.fmt('<h1>{}</h1>', { u.i(1, 'Heading 1') })),
  u.s('h2', u.fmt('<h2>{}</h2>', { u.i(1, 'Heading 2') })),
  u.s('h3', u.fmt('<h3>{}</h3>', { u.i(1, 'Heading 3') })),
  u.s('h4', u.fmt('<h4>{}</h4>', { u.i(1, 'Heading 4') })),
  u.s('h5', u.fmt('<h5>{}</h5>', { u.i(1, 'Heading 5') })),
  u.s('h6', u.fmt('<h6>{}</h6>', { u.i(1, 'Heading 6') })),

  -- Paragraphs and text
  u.s('p', u.fmt('<p>{}</p>', { u.i(1, 'Paragraph text') })),
  u.s('span', u.fmt('<span>{}</span>', { u.i(1, 'Inline text') })),
  u.s('strong', u.fmt('<strong>{}</strong>', { u.i(1, 'Bold text') })),
  u.s('em', u.fmt('<em>{}</em>', { u.i(1, 'Italic text') })),
  u.s('a', u.fmt('<a href="{}">{}</a>', { u.i(1, '#'), u.i(2, 'Link text') })),

  -- Lists
  u.s(
    'ul',
    u.fmt(
      [[
  <ul>
    <li>{}</li>
    <li>{}</li>
  </ul>
  ]],
      { u.i(1, 'Item 1'), u.i(2, 'Item 2') }
    )
  ),
  u.s(
    'ol',
    u.fmt(
      [[
  <ol>
    <li>{}</li>
    <li>{}</li>
  </ol>
  ]],
      { u.i(1, 'Item 1'), u.i(2, 'Item 2') }
    )
  ),

  -- Forms
  u.s(
    'form',
    u.fmt(
      [[
  <form action="{}" method="{}">
    {}
    <button type="submit">{}</button>
  </form>
  ]],
      { u.i(1, '#'), u.i(2, 'post'), u.i(3, ''), u.i(4, 'Submit') }
    )
  ),

  u.s('input', u.fmt('<input type="{}" name="{}" value="{}" />', { u.i(1, 'text'), u.i(2, 'name'), u.i(3, '') })),
  u.s('textarea', u.fmt('<textarea name="{}">{}</textarea>', { u.i(1, 'name'), u.i(2, '') })),
  u.s(
    'select',
    u.fmt(
      [[
  <select name="{}">
    <option value="{}">{}</option>
    <option value="{}">{}</option>
  </select>
  ]],
      { u.i(1, 'name'), u.i(2, '1'), u.i(3, 'Option 1'), u.i(4, '2'), u.i(5, 'Option 2') }
    )
  ),

  -- Images and media
  u.s('img', u.fmt('<img src="{}" alt="{}" />', { u.i(1, 'image.png'), u.i(2, 'Description') })),
  u.s(
    'video',
    u.fmt(
      [[
  <video controls>
    <source src="{}" type="video/{}">
    Your browser does not support the video tag.
  </video>
  ]],
      { u.i(1, 'video.mp4'), u.i(2, 'mp4') }
    )
  ),
  u.s(
    'audio',
    u.fmt(
      [[
  <audio controls>
    <source src="{}" type="audio/{}">
    Your browser does not support the audio element.
  </audio>
  ]],
      { u.i(1, 'audio.mp3'), u.i(2, 'mpeg') }
    )
  ),

  -- Tables
  u.s(
    'table',
    u.fmt(
      [[
  <table>
    <thead>
      <tr>
        <th>{}</th>
        <th>{}</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{}</td>
        <td>{}</td>
      </tr>
    </tbody>
  </table>
  ]],
      { u.i(1, 'Header 1'), u.i(2, 'Header 2'), u.i(3, 'Data 1'), u.i(4, 'Data 2') }
    )
  ),

  -- Semantic elements
  u.s('section', u.fmt('<section>\n  {}\n</section>', { u.i(1, '') })),
  u.s('article', u.fmt('<article>\n  {}\n</article>', { u.i(1, '') })),
  u.s('header', u.fmt('<header>\n  {}\n</header>', { u.i(1, '') })),
  u.s('footer', u.fmt('<footer>\n  {}\n</footer>', { u.i(1, '') })),
  u.s('nav', u.fmt('<nav>\n  {}\n</nav>', { u.i(1, '') })),

  -- Containers
  u.s('div', u.fmt('<div>\n  {}\n</div>', { u.i(1, '') })),
  u.s('main', u.fmt('<main>\n  {}\n</main>', { u.i(1, '') })),
  u.s('aside', u.fmt('<aside>\n  {}\n</aside>', { u.i(1, '') })),

  -- Metadata and SEO
  u.s('meta-charset', u.fmt('<meta charset="{}">', { u.i(1, 'UTF-8') })),
  u.s('meta-viewport', u.fmt('<meta name="viewport" content="{}">', { u.i(1, 'width=device-width, initial-scale=1.0') })),
  u.s('meta-description', u.fmt('<meta name="description" content="{}">', { u.i(1, 'Page description') })),
  u.s('meta-keywords', u.fmt('<meta name="keywords" content="{}">', { u.i(1, 'HTML, CSS, JavaScript') })),
  u.s('meta-author', u.fmt('<meta name="author" content="{}">', { u.i(1, 'Author Name') })),

  -- Link elements
  u.s('link-css', u.fmt('<link rel="stylesheet" href="{}">', { u.i(1, 'style.css') })),
  u.s('link-favicon', u.fmt('<link rel="icon" href="{}" type="{}">', { u.i(1, 'favicon.ico'), u.i(2, 'image/x-icon') })),

  -- Script elements
  u.s('script-src', u.fmt('<script src="{}"></script>', { u.i(1, 'script.js') })),
  u.s('script-inline', u.fmt('<script>\n  {}\n</script>', { u.i(1, '// JS code here') })),

  -- Forms advanced
  u.s('button', u.fmt('<button type="{}">{}</button>', { u.i(1, 'button'), u.i(2, 'Click Me') })),
  u.s('checkbox', u.fmt('<input type="checkbox" name="{}" value="{}" {}>', { u.i(1, 'name'), u.i(2, 'value'), u.i(3, '') })),
  u.s('radio', u.fmt('<input type="radio" name="{}" value="{}" {}>', { u.i(1, 'group'), u.i(2, 'value'), u.i(3, '') })),
  u.s('file', u.fmt('<input type="file" name="{}" {}>', { u.i(1, 'fileUpload'), u.i(2, '') })),
  u.s('password', u.fmt('<input type="password" name="{}" placeholder="{}">', { u.i(1, 'password'), u.i(2, 'Password') })),
  u.s('email', u.fmt('<input type="email" name="{}" placeholder="{}">', { u.i(1, 'email'), u.i(2, 'Email address') })),
  u.s('number', u.fmt('<input type="number" name="{}" min="{}" max="{}" value="{}">', { u.i(1, 'quantity'), u.i(2, '0'), u.i(3, '10'), u.i(4, '0') })),
  u.s('range', u.fmt('<input type="range" name="{}" min="{}" max="{}" value="{}">', { u.i(1, 'range'), u.i(2, '0'), u.i(3, '100'), u.i(4, '50') })),

  -- Media
  u.s('audio-autoplay', u.fmt('<audio src="{}" controls autoplay></audio>', { u.i(1, 'audio.mp3') })),
  u.s('video-autoplay', u.fmt('<video src="{}" controls autoplay muted loop></video>', { u.i(1, 'video.mp4') })),
  u.s('iframe', u.fmt('<iframe src="{}" width="{}" height="{}" {}></iframe>', { u.i(1, 'url'), u.i(2, '600'), u.i(3, '400'), u.i(4, '') })),

  -- Links and navigation
  u.s('a-blank', u.fmt('<a href="{}" target="_blank" rel="noopener noreferrer">{}</a>', { u.i(1, '#'), u.i(2, 'External Link') })),
  u.s(
    'nav-list',
    u.fmt(
      [[
  <nav>
    <ul>
      <li><a href="{}">{}</a></li>
      <li><a href="{}">{}</a></li>
    </ul>
  </nav>
  ]],
      { u.i(1, '#'), u.i(2, 'Home'), u.i(3, '#'), u.i(4, 'About') }
    )
  ),

  -- Semantic interactive
  u.s('details', u.fmt('<details>\n  <summary>{}</summary>\n  {}\n</details>', { u.i(1, 'Title'), u.i(2, 'Content') })),
  u.s('dialog', u.fmt('<dialog open>\n  {}\n</dialog>', { u.i(1, 'Dialog content') })),
  u.s('progress', u.fmt('<progress value="{}" max="{}">{}</progress>', { u.i(1, '50'), u.i(2, '100'), u.i(3, '50%') })),
  u.s('meter', u.fmt('<meter value="{}" min="{}" max="{}">{}</meter>', { u.i(1, '0.6'), u.i(2, '0'), u.i(3, '1'), u.i(4, '60%') })),

  -- Lists advanced
  u.s('dl', u.fmt('<dl>\n  <dt>{}</dt>\n  <dd>{}</dd>\n</dl>', { u.i(1, 'Term'), u.i(2, 'Description') })),

  -- Tables advanced
  u.s(
    'thead-tbody',
    u.fmt(
      [[
  <table>
    <thead>
      <tr>
        <th>{}</th>
        <th>{}</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{}</td>
        <td>{}</td>
      </tr>
      <tr>
        <td>{}</td>
        <td>{}</td>
      </tr>
    </tbody>
  </table>
  ]],
      { u.i(1, 'Header1'), u.i(2, 'Header2'), u.i(3, 'Row1Col1'), u.i(4, 'Row1Col2'), u.i(5, 'Row2Col1'), u.i(6, 'Row2Col2') }
    )
  ),

  -- Misc tags
  u.s('abbr', u.fmt('<abbr title="{}">{}</abbr>', { u.i(1, 'Abbreviation'), u.i(2, 'abbr') })),
  u.s('cite', u.fmt('<cite>{}</cite>', { u.i(1, 'Citation') })),
  u.s('code', u.fmt('<code>{}</code>', { u.i(1, 'Code') })),
  u.s('mark', u.fmt('<mark>{}</mark>', { u.i(1, 'Highlighted') })),
  u.s('small', u.fmt('<small>{}</small>', { u.i(1, 'Small text') })),
  u.s('sub', u.fmt('<sub>{}</sub>', { u.i(1, 'Subscript') })),
  u.s('sup', u.fmt('<sup>{}</sup>', { u.i(1, 'Superscript') })),
  u.s('time', u.fmt('<time datetime="{}">{}</time>', { u.i(1, '2025-09-05'), u.i(2, 'September 5, 2025') })),
  u.s('wbr', u.t '<wbr>'),

  -- Global attributes snippet
  u.s(
    'attr-class-id-style',
    u.fmt(
      '<{} class="{}" id="{}" style="{}">{}</{}>',
      { u.i(1, 'div'), u.i(2, 'classname'), u.i(3, 'idname'), u.i(4, 'color:red;'), u.i(5, 'Content'), u.i(1, 'div') }
    )
  ),

  -- ARIA attributes example
  u.s('aria-button', u.fmt('<button aria-label="{}" role="button">{}</button>', { u.i(1, 'Close menu'), u.i(2, 'X') })),
}
