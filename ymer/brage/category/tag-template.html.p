<html>

<head>
  <meta charset="UTF-8">
  <meta name="google" content="notranslate">
  <meta http-equiv="Content-Language" content="en">
  <title>mstill.io/◊(select 'title here)</title>
  <script src="//use.typekit.net/ubv3gvw.js" type="text/javascript"></script>
  <script type="text/javascript">
    try {
      Typekit.load();
    } catch (e) {}
  </script>
  <link rel="stylesheet" type="text/css" href="../../svartalv/css/monokai.css" />
  <link rel="stylesheet" type="text/css" href="../../svartalv/css/style.css" />
  <link rel="shortcut icon" href="../../favicon.ico" type="image/x-icon" />


  ◊when/block[(select-from-metas 'background here)]{
  <style>
    #header {
      background-image: url(◊(select-from-metas 'background metas));
      background-size: cover;
      background-position: center top;
      margin-bottom: 6em;
    }
  </style>
  }

</head>

<body>
  <div id="header">
    <a href="../index.html">
      <img src="../../svartalv/bilder/logo-fjaril.png" />
    </a>
    <span class="righty">
      <a href="index.html">&uarr;</a>
      <a href="../../index.ptree">&delta;</a>
    </span>
  </div>

  <div id="avsnitt">
    ◊(->html `(h1 "Category: " ,(select 'title here)))
    ◊(add-between (map (λ (x)
    (->html `(div [[class "abstract"]]
    (h2 ,(select 'h1 x))
    (p ((class "index-date")) "Posted on "
    ,@(format-date (select-from-metas 'publish-date x))
    " in Category "
    ,@(format-cats (select-from-metas 'categories x)))
    (p ,@(get-elements (select-element 'p 'body x))
    (br)
    (a [[href ,(string-append "../" (symbol->string x))]
    [class "readmore"]]
    "Mer")))))
    (filter (λ (file)
    (tag-in-file? (select 'title here) file))
    (children 'index.html)))
    (->html `(hr)))
  </div>


  <footer>
  </footer>

</body>

</html>
