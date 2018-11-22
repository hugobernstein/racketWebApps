<html>

<head>
  <meta charset="UTF-8">
  <meta name="google" content="notranslate">
  <meta http-equiv="Content-Language" content="en">
  <title>◊(remove-tags (select 'headline here)), mstill.io</title>
  <script src="//use.typekit.net/ubv3gvw.js" type="text/javascript"></script>
  <script type="text/javascript">
    try {
      Typekit.load();
    } catch (e) {}
  </script>
  <link rel="stylesheet" type="text/css" href="../svartalv/css/monokai.css" />
  <link rel="stylesheet" type="text/css" href="../svartalv/css/style.css" />
  <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />

  <script type="text/javascript" src='../svartalv/vendor/jquery-3.2.1.min.js'></script>
  <script type="text/javascript">
    $("#article").ready(function(){
    var cnt=0;
    var minute1=0;
    var minute2=0;
    var content = $('#article').text();
    if(content.length < 1)
    　　return;
    cnt = content.length - content.match(/[\r\n]/g).length
    console.log(cnt / 500);
    console.log(cnt / 300);
    minute1 = Math.round(cnt / 500); //500为每分钟阅读字数
    minute2 = Math.round(cnt / 300);
    var span = document.createElement("span");
    span.setAttribute("class","mitten");
    span.innerHTML="Det finns ungefär " + cnt + " ord，behöver " + minute1 + "~" + minute2 + " minuter att läsa";
    $("#toc").after(span);
    });
  </script>

  ◊when/block[(select-from-metas 'background here)]{
  <style>
    #header {
      background-image: url(◊(select-from-metas 'background metas));
      background-size: cover;
      background-position: center top;
      margin-bottom: 6rem;
      }
    </style>
  }




</head>

<body>
  <div id="header">
    <a href="../index.html">
      <img src="../svartalv/bilder/logo-fjaril-vit.png" />
    </a>
    <span class="righty">
      <a href="index.html">&uarr;</a>
      <a href="../../index.ptree">&delta;</a>
    </span>

  </div>

  <div id="avsnitt" class="sketch__pattern">
    ◊(->html `(p ((class "date")) ,@(format-date (select-from-metas 'publish-date here))))
    ◊(->html (select 'headline here))

    ◊when/splice[(select-from-metas 'categories here)]{
    ◊(->html `(div ((class "category"))
    ,@(format-cats (select-from-metas 'categories here))))
    }



    ◊when/splice[(select-from-metas 'toc here)]{
    ◊(->html `(div [[id "toc"]] (h2 "Table of Contents")
    ,@(select-from-doc 'toc-entries here)))
    }
    <div id="article">
      ◊(map ->html (select-from-doc 'body here))
    </div>

  </div>

  <footer>
  </footer>





</body>

</html>
