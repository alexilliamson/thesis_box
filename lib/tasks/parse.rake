require 'rubygems'
require 'stemmify'
require 'pry'

task :parse => :environment do

  $stopwords = ["unanimous consent","extend","member","revise", "members" , "pro tempore", "use later in the day","mr. president" "completes business", "business today", "resume","legislative","objection", "i ask", "senate", "senator", "senators", "gentleman","recess", "representative", "session", "committee" , "unanimous", "consent", "presiding", "object", "tempore", "clerk", "presiding", "meetsessione", "proceed", "withdraw","chair","committee" ,"i", "unanimous consent","presiding Officer","rollcall", "yield","mr", "united", "states", "congressional", "congress", "the",
"be",
"to",
"of",
"and",
"a",
"in",
"that",
"have",
"i",
"it",
"for",
"not",
"on",
"with",
"he",
"as",
"you",
"do",
"at",
"this",
"but",
"his",
"by",
"from",
"they",
"we",
"say",
"her",
"she",
"or",
"an",
"will",
"my",
"one",
"all",
"would",
"there",
"their",
"what",
"so",
"up",
"out",
"if",
"about",
"who",
"get",
"which",
"go",
"me",
"when",
"make",
"can",
"like",
"time",
"no",
"just",
"him",
"know",
"take",
"people",
"into",
"year",
"your",
"good",
"some",
"could",
"them",
"see",
"other",
"than",
"then",
"now",
"look",
"only"]
  $killwords = ["following the prayer","journal of proceedings"]
        puts(Time::now)
        Page.includes(:person).find_each(:start => 76715) { |page|
          if page.id % 100 == 0
            puts(page.id)
          end
          kill = false
          text = page.text.downcase
          year = page.person.year
          branch = page.person.branch

          $killwords.each {|w|
            if text.include? (w)
              kill = true
              puts("AHAHAHA #{w}")
              puts(text)
              break
            end
          } 

          if kill == false
            words = []
            parse = text
            parse.gsub!(/[^a-z ]/, ' ')
            parse.gsub!(/ . /, ' ')
            $stopwords.each {|x| parse.gsub!(" #{x} ", " ")}
            parse = parse.split
            (0..(parse.length-2)).each {|b| 
              words = parse[b] + ' ' + parse[b+1]
              stem = parse[b].stem + ' ' + parse[b+1].stem
              @word = Word.where(:stem => stem, :year => year, :branch => branch).first_or_create(:text => words)
              page.words << @word
            }
            end 

          # if kill == true
          #   page.destroy
          # end

        }
      puts(Time::now)

    
end

