require 'rubygems'
require 'watir-webdriver'
require 'pry'

#ADDindextermsfrompublishercriteria


task :search => :environment do
	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 180 # seconds – default is 60

	browser = Watir::Browser.new :firefox, :http_client => client
	browser.goto "http://infoweb.newsbank.com.turing.library.northwestern.edu/iw-search/we/InfoWeb?p_product=AWNB&p_action=explore&p_theme=aggregated5&p_nbid=S55L4CLGMTM2ODU1MDIyNy40NDI2NTk6MToxNToxMjkuMTA1LjIxNS4xNDY&p_clear_search=yes&d_refprod=NEWSARCHIVES&f_clearContext=yes"
	browser.text_field(:name => 'IDToken1').set "abw724"
	browser.text_field(:name => 'IDToken2').set "@4k5k6k7"
	browser.button(:name => 'Login.Submit').click
	browser.link(:text => 'North America').click
	browser.link(:text => 'United States').click
	browser.button(:text=> 'Source Types').click
	browser.link(:text => 'Newspapers').click
	browser.button(:text => 'Source List').click
	url = browser.url

	
	stems1994 = Phrase.where('chi2 > 0').order('chi2 DESC').limit(50).offset(660).pluck(:id)
	stems2012 = Phrase.where('chi2 > 0').order('chi2b DESC').limit(50).offset(287).pluck(:id)
	(30..3232).each {|n|
		row = browser.table[n]	

		if row[2].text[6..9].to_i <= 1994 and  row[2].text[17..20] == 't'
			year = 1994
			link = row[1].link.href
			@paper = Paper.create(:name => row[1].text, :year => year, :state => row[3].text[0..1])
			stems1994.each{|stem|
				browser.goto link
				word = Use.where(:phrase_id => stem).pluck(:text).uniq.first
				search =  word.split[0] + " " +"ADJ2" + " " + word.split[1] + " " +"ADJ2" + " " + word.split[2]
				browser.text_field(:name => 'p_text_base-0').set search
				browser.text_field(:id => 'searchText-2-dateInput').set "Jan #{year} - Dec #{year}"
				browser.button(:text=> 'Search').click	
				if browser.div(:id=> 'navBreadcrumb').exists? 
					count = browser.div(:id=> 'navBreadcrumb').text.gsub!(/[^0-9]/,'').to_i	
					PaperUse.create(:phrase_id => stem, :paper_id => @paper.id, :frequency => count)
				else
					PaperUse.create(:phrase_id => stem, :paper_id => @paper.id, :frequency => 0)
				end
			}

			year = 2012
			@paper = Paper.create(:name => @paper.name, :year => year, :state => @paper.state)
			stems2012.each{|stem|
				browser.goto link
				word = Use.where(:phrase_id => stem).pluck(:text).uniq.first
				search =  word.split[0] + " " +"ADJ2" + " " + word.split[1] + " " +"ADJ2" + " " + word.split[2]
				browser.text_field(:name => 'p_text_base-0').set search
				browser.text_field(:id => 'searchText-2-dateInput').set "Jan #{year} - Dec #{year}"
				browser.button(:text=> 'Search').click	
				if browser.div(:id=> 'navBreadcrumb').exists? 
					count = browser.div(:id=> 'navBreadcrumb').text.gsub!(/[^0-9]/,'').to_i	
					PaperUse.create(:phrase_id => stem, :paper_id => @paper.id, :frequency => count)
				else
					PaperUse.create(:phrase_id => stem, :paper_id => @paper.id, :frequency => 0)
				end
			}
			browser.goto url
		end
	}


  
end