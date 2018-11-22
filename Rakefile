require 'fileutils'

ROOT = "./"
YMER = "./ymer"
MIMER = "./mimer"
BRAGE = "./ymer/brage"

CONFIG = {
  'pollen_sida' => File.join(YMER),
  'pollen_utkast' => File.join(BRAGE),
  'pollen_ext' => "html.pm",
  'orgmode_utkast' => File.join(MIMER, "dotorg"),
  'orgmode_ext' => "org",
  'pug_sida' => File.join(YMER, "dotpug"),
  'pug_utkast' => File.join(YMER, "dotpug"),
  'pug_ext' => "pug"
}

# definitioner
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/,/, '/')}") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

task :rensa do
  sh 'find . -type d -iname "compiled" | xargs rm -rfv'
end

namespace :utkast do
  namespace :skapa do
    namespace :orgmode do
      desc "Skapa ett orgmode fil i #{CONFIG['orgmode_utkast']}"
      task :orgmode, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['orgmode_utkast']}" unless FileTest.directory?(CONFIG['orgmode_utkast'])
        title = get_stdin("Ange ett namn: ")
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
        end
        filnamn = File.join(CONFIG['orgmode_utkast'], "#{date}-#{slug}.#{CONFIG['orgmode_ext']}")
        if File.exist?(filnamn)
          abort("rake aborted!") if ask("Filen #{filnamn} finns redan. Vill du skriva över?", ['y', 'n']) == 'n'
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"
        open(filnamn, 'w') do |post|
          post.puts "\#\+TITLE:#{title.gsub(/-/, ' ')}"
          post.puts "\#\+OPTIONS: toc:nil"
          post.puts "\#\+STARTUP: showall indent"
          post.puts "\#\+STARTUP: hidestars"
        end
      end

      desc "Skapa ett orgmode fil i #{CONFIG['orgmode_utkast']}"
      task :orgmodeTeX, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['orgmode_utkast']}" unless FileTest.directory?(CONFIG['orgmode_utkast'])
        title = get_stdin("Ange ett namn: ")
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
        end
        filnamn = File.join(CONFIG['orgmode_utkast'], "#{date}-tex-#{slug}.#{CONFIG['orgmode_ext']}")
        if File.exist?(filnamn)
          abort("rake aborted!") if ask("Filen #{filnamn} finns redan. Vill du skriva över?", ['y', 'n']) == 'n'
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"
        open(filnamn, 'w') do |post|
          post.puts "\#\+TITLE:#{title.gsub(/-/, ' ')}"
          post.puts "\#\+OPTIONS: toc:nil"
          post.puts "\#\+STARTUP: showall indent"
          post.puts "\#\+STARTUP: hidestars"
          post.puts "\#\+LATEX_CLASS: article"
          post.puts "\#\+LATEX_CLASS_OPTIONS: [a4paper]"
          post.puts "\#\+LATEX_HEADER: \\usepackage{xeCJK,fontenc,xltxtra,xunicode}"
          post.puts "\#\+LATEX_HEADER: \\defaultfontfeatures{Mapping=tex-text}"
          post.puts "\#\+LATEX_HEADER: \\setCJKmainfont{Hiragino Sans GB}"
          post.puts "\#\+LATEX_HEADER: \\setmainfont[Mapping=tex-text, Color=textcolor]{Helvetica Neue Light}"
          post.puts "\#\+LATEX_HEADER: \\XeTeXlinebreaklocale \"zh\""
          post.puts "\#\+LATEX_HEADER: \\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt"
          post.puts "\#\+LATEX_HEADER: \\newfontfamily\\bodyfont[]{Helvetica Neue}"
          post.puts "\#\+LATEX_HEADER: \\newfontfamily\\thinfont[]{Helvetica Neue UltraLight}"
          post.puts "\#\+LATEX_HEADER: \\newfontfamily\\headingfont[]{Helvetica Neue Condensed Bold}"
          post.puts "\#\+LATEX_HEADER: \\renewcommand\\abstractname{\\textit{Exekutiv Sammanfattning}}"
          post.puts "\#\+LATEX_HEADER: \\renewcommand\\contentsname{\\textit{Inneh\\r{a}ll}}"

          post.puts "\\hrule"
          post.puts "\\begin{abstract}"
          post.puts "\\noindent"
          post.puts "\\vspace{3ex}"
          post.puts "\\end{abstract}"
          post.puts "\\tableofcontents"
          post.puts "\\vspace{3ex}"
          post.puts "\\hrule"
          post.puts "\\vspace{3ex}"
          post.puts "\\begin\{center\}"
          post.puts "  \\noindent Powered by OrgMode and \LaTeX{}"
          post.puts "\\end\{center\}"
          post.puts "\\newpage"
        end
      end

    end

    namespace :pollen do
      desc "Att skapa en ny sida"
      task :sidan, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pollen_sida']}" unless FileTest.directory?(CONFIG['pollen_sida'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        filnamn = File.join(CONFIG['pollen_sida'], "#{slug}.#{CONFIG['pollen_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Det finns \"#{filnamn}\" redan. Vill du skriva över?", ['j','N']) == 'n'
          # Det finns en bugg
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts '#lang pollen'
          post.puts '◊(define-meta template "mallen-sidan.html")'
          post.puts '◊(define-meta title "")'
          post.puts '◊(define-meta author "Hugo Bernstein")'
          post.puts '◊(define-meta action "")'
          post.puts '◊(define-meta desc "")'
          post.puts ''
          post.puts '◊section{'
          post.puts '  ◊article{}'
          post.puts "  ◊aside{◊em{◊(hash-ref metas 'desc)}}"
          post.puts "}"
        end
      end

      desc "Att skapa ett nyt artikel med stilen:mstill"
      task :utkastMstill => [:rensa]
      task :utkastMstill, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pollen_utkast']}" unless FileTest.directory?(CONFIG['pollen_utkast'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
          idag = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%d/%m/%Y')
        end
        filnamn = File.join(CONFIG['pollen_utkast'], "#{date}-#{slug}-pm.#{CONFIG['pollen_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Filen #{filnamn} finns redan. Vill du skriva över?", ['j','N'] ) == 'n'
        end

        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts '#lang pollen/markup'
          post.puts "◊headline{#{slug}◊sup{alpha}}"
          post.puts '◊(define-meta background "../svartalv/bilder/background.jpeg")'
          post.puts "◊define-meta[coverimg]{../svartalv/bilder/background.jpeg}"
          post.puts "◊define-meta[publish-date]{#{idag}}"
          # post.puts '◊(define-meta publish-date "#{idag}")'
          post.puts '◊(define-meta author "Hugo Bernstein")'
          post.puts '◊(define-meta categories "blog")'
          post.puts '◊(define-meta toc "true")'
          post.puts ''
          post.puts '◊section{intro}'
          post.puts 'Considering the impact of that FOO has on the field of...'
          post.puts "◊nosection{Källor}"
          post.puts '◊ol[#:class "hebrew"]{'
          post.puts '  ◊li{◊link[""]{}}'
          post.puts "}"

        end
      end
    end

    namespace :pug do
      desc "Att skapa en pug-sida"
      task :ren, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pug_sida']}" unless FileTest.directory?(CONFIG['pug_sida'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        filnamn = File.join(CONFIG['pug_sida'], "#{slug}.#{CONFIG['pug_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Det finns redan \"#{filnamn}\". Vill du skriva över?", ['j', 'N']) == 'N'
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts 'doctype html'
          post.puts 'html'
          post.puts '  include _includes/_head.pug'
          post.puts '  body.sketch__pattern'
          post.puts '    include _includes/_topnav.pug'
          post.puts '    include _includes/_footer.pug'

        end
      end

      desc "Att skapa en pug-sida"
      task :sida, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pug_sida']}" unless FileTest.directory?(CONFIG['pug_sida'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

        filnamn = File.join(CONFIG['pug_sida'], "#{slug}.#{CONFIG['pug_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Det finns redan \"#{filnamn}\". Vill du skriva över?", ['j', 'N']) == 'N'
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts 'doctype html'
          post.puts 'html'
          post.puts '  include _includes/_head.pug'
          post.puts '  body.sketch__pattern'
          post.puts '    include _includes/_topnav.pug'
          post.puts '    #scroll-animate'
          post.puts '      #scroll-animate-main'
          post.puts '        .wrapper-parallax'
          post.puts '          .header__parallax(style="background-image:url(svartalv/bilder/parallax/parallaxen-forvalda0.jpg);")'
          post.puts '            h1.parallax titel'
          post.puts '          section.content__parallax'
          post.puts '            #gyllenesnittet'
          post.puts '              .sektion'
          post.puts '                article'
          post.puts '                aside'
          post.puts '          include _includes/_footer-parallax.pug'
          post.puts '    include _includes/_scripts.pug'

        end
      end

      desc "Att skapa ett pug-artikel"
      task :utkast, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pug_utkast']}" unless FileTest.directory?(CONFIG['pug_utkast'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
        end
        filnamn = File.join(CONFIG['pug_utkast'], "#{date}-viapug-#{slug}.#{CONFIG['pug_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Det finns redan \"#{filnamn}\". Vill du skriva över?", ['j', 'N']) == 'N'
        end
        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts 'doctype html'
          post.puts 'html'
          post.puts '  include _includes/_head.pug'
          post.puts '  body.sketch__pattern'
          post.puts '    include _includes/_topnav.pug'
          post.puts '    .CoverImage'
          post.puts "      img(src='svartalv/bilder/bildspel/bildspelet-forvalda0.jpeg')"
          post.puts '    #gyllenesnittet'
          post.puts '      .sektion'
          post.puts '        article'
          post.puts '        aside'
          post.puts '    include _includes/_footer.pug'
          post.puts '    include _includes/_scripts.pug'
        end
      end
    end
  end
end
