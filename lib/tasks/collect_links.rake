require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :collect_links => :environment do
  file = File.new("links1994.txt","r+")
  Watir::Wait.until(500) { 
  browser = Watir::Browser.new
  browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC'
  years = Array.new
  browser.links(:text => /\s*[1][9][9][4-5]\s*\z/).each{|link| years = years << link.text}
  years = years.drop(1)
  pages = []
  years.each {|year|
    browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
    browser.link(:text => year).click
    months = Array.new
    browser.links(:text => /^[JFMASOND][a-hj-z][a-z]{,8}\z/).each{|link| months = months << link.text}

    months.each {|month|
      browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
      browser.link(:text => year).click
      browser.link(:text => month).click
      days = Array.new
      browser.links(:text => /day, /).each{|link| days = days << link.text}

      days.each {|day|
        browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
        browser.link(:text => year).click
        browser.link(:text => month).click
        browser.link(:text => day).click
        sections = Array.new
        browser.links(:text => /(Senate|House)/).each{|link| sections = sections << link.text}

        sections.each {|section|
          browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
          browser.link(:text => year).click
          browser.link(:text => month).click
          browser.link(:text => day).click
          browser.link(:text => section).click
          browser.links(:text => 'Text').each{|link| file = file << link.href << "\n"}

        }
      }
    }
  }
  }

  newtext = file.gets(sep = nil).gsub(/\n.*FrontMatter\.htm/,'')
  file.close
  file = File.new("link1994.txt","w")
  file = file << newtext
  file.close
end