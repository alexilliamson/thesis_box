require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :collect_links => :environment do
  years = []
  pages = []
  months = []
  days = []
  sections = []

  Watir::Wait.until(500) { 
  browser = Watir::Browser.new
  browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC'

  browser.links(:text => /\s*[12][90][901][0-9]\s*\z/).each{|link| years << link.text}

  years.each do |year|
    browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
    browser.link(:text => year).click
    browser.links(:text => /^[JFMASOND][a-hj-z][a-z]{,8}\z/).each{|link| months << link.text}

    months.each do |month|
      browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
      browser.link(:text => year).click
      browser.link(:text => month).click
      browser.links(:text => /day, /).each{|link| days << link.text}

      days.each do |day|
        browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
        browser.link(:text => year).click
        browser.link(:text => month).click
        browser.link(:text => day).click
        
        browser.links(:text => /(Senate|House)/).each{|link| sections << link.text}

        sections.each do |section|
          browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
          browser.link(:text => year).click
          browser.link(:text => month).click
          browser.link(:text => day).click
          browser.link(:text => section).click
          browser.links(:text => 'Text').each{|link| Link.create( :url => link.href, :day => day, :month => month, :year => year, :chamber => section)}

        end
      end
    end
  end
  }

end