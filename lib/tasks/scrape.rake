require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :scrape => :environment do
  puts(Time::now)
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 180 # seconds – default is 60

  browser = Watir::Browser.new :firefox, :http_client => client
  File.new("link1994.txt","r+").each_line {|page|
      browser.goto page
      @year = page[34..37]
      case page[72]
      when 'S'
        @branch= 'S'
      when 'H'
        @branch = 'H'
      else
        @branch = 'X'
      end
      text = browser.text
      text.gsub!(/Mrs. /, "Mr. ")
      text.gsub!(/Mr. DE LUGO/, "Mr. DELUGO")
      text.gsub!(/GARZA/, "Mr. DELAGARZA")
      text.gsub!(/-/, "")
      text.gsub!(/The PRESIDING OFFICER/, "Mr. PRESIDINGOFFICER")
      text.gsub!(/The SPEAKER PRO TEMPORE/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/The PRESIDENT PRO TEMPORE/, "Mr. PRESPROTEMPORE")
      text.gsub!(/The CLERK/, "Mr. CLERK")
      text.gsub!(/The PRESIDENT/, "Mr. PRESIDENT")
      text.gsub!(/The ACTING PRESIDENT/, "Mr. PRESIDENT")
      text.gsub!(/The VICE PRESIDENT/, "Mr. VPRESIDENT")
      text.gsub!(/The SPEAKER/, "Mr. SPEAKER")
      text.gsub!(/The CHAIRMAN/, "Mr. CHAIRMAN")


      names = text.scan(/([M][r]. [A-Z][^\.][A-Z]{1,}*\.|[M][r]. [A-Z].[A-Z]{1,} of [A-Z][a-z]*\.)/)
      sections = text.split(/[MT][rh]. [A-Z].[A-Z]{1,}*\./)
      sections.slice!(0)
      names.flatten!
      sections.each_index {|i|
        
          @name = (names[i].gsub(/Mr. /, '')).upcase.gsub(/[^a-zA-Z ]/,'')
          @person = Person.find_or_create_by_name_and_year_and_branch(:name => @name, :year => 1994, :branch => @branch)
          @page = @person.pages.create(:title => page , :text => sections[i])

      }
    }
    browser.close

  
  puts(Time::now)

end