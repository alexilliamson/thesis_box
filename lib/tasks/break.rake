require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'stemmify'


task :break => :environment do
	#RUN THE FOLLOWING TO FIX THE HOUSE/SENATE CLASSIFCATION PROBLEM
	# Person.where(:party => nil).find_each {|misperson|

	# 	if misperson.branch == 'H'
	# 		@reperson = Person.where(:name => misperson.name, :branch => 'S').first_or_initialize
	# 		if @reperson.party != nil
	# 			puts(@reperson.pages.count)
	# 			@reperson.pages << misperson.pages
	# 			misperson.destroy
	# 			puts(@reperson.pages.count)
	# 		end
	# 	end

	# 	if misperson.branch == 'S'
	# 		@reperson = Person.where(:name => misperson.name, :branch => 'H').first_or_initialize
	# 		if @reperson.party != nil
	# 			puts(@reperson.pages.count)
	# 			@reperson.pages << misperson.pages
	# 			misperson.destroy
	# 			puts(@reperson.pages.count)
	# 		end
	# 	end
	# }





	#RUN THE FOLLOWING TO FIX 'THE US ASSIGNMENT'
	# Person.find_by_name('THE US').pages.each {|p|
	# 	id = p.id
	# 	p.person_id = Page.find((id-1)).person_id 
	# 	p.save
	# }	
	# Person.where(:id => (Person.find_by_name('THE US').id)).destroy

	# Person.find_by_name('THE UN').pages.each {|p|
	# 	id = p.id
	# 	p.person_id = Page.find((id-1)).person_id 
	# 	p.save
	# }	
	# Person.where(:name => 'THE UN').destroy_all

	#FIND THE WHATS - there were 130 abbreviations, the rest are being fixed
	total= []
	  client = Selenium::WebDriver::Remote::Http::Default.new
	  client.timeout = 180 # seconds – default is 60
	  browser = Watir::Browser.new :firefox, :http_client => client
	  Person.where(:name => 'WHATIS').all.each {|person|
	  	person.pages.select(:title).uniq.each {|page|
			  page = page.title
		      browser.goto page
		      @text = browser.text
		      names = @text.scan(/The [A-Z]{3,}/)
		      total << names.uniq
		      puts(names.uniq)
		      puts(page)
		        }
      puts(total.flatten.uniq)
  }


end




# The SPEAKER
# The CHAIRMAN
# The OMB
# The ACIR
# The FEC
# The GAO
# The GSA
# The DOL
# The BRAC
# The CBO
# The MANTECH
# The NATO
# The TRP
# The FFRDC
# The YMCA
# The YWCA
# The BMD
# The NIJ
# The DOD
# The BUR
# The CINC
# The PRESIDING
# The DOE
# The ADSFM
# The ASEH
# The NUNN
# The THURMOND
# The MNRC
# The OPM
# The NAAA
# The SRAW
# The BDM
# The LHD
# The FDA
# The AALA
# The FAA
# The FTA
# The CFO
# The AICPA
# The DOT
# The ICC
# The EPA
# The HUD
# The CDBG
# The AMA
# The AFL
# The BIA
# The FAP
# The EDA
# The TCEDC
# The ARC
# The NRDC
# The NAD
# The USDA
# The GSM
# The CBC
# The NED
# The EEOC
# The ACLU
# The BES
# The BER
# The ITER
# The JCT
# The TPX
# The DARE
# The LPA
# The APPLE
# The NEA
# The SBA
# The FHA
# The FBI
# The BLM
# The NPR
# The SELENE
# The JCOC
# The DSG
# The CIA
# The NHS
# The ISTEA
# The FBF
# The CEF
# The ATP
# The NAGB
# The NURP
# The INS
# The ATF
# The NRA
# The TEC
# The ABA
# The RJA
# The NSF
# The NBS
# The IRS
# The DEP
# The CALPERS
# The PADC
# The IHS
# The FTE
# The MMS
# The NASCAR
# The NIST
# The NIC
# The LSC
# The ZIP
# The NAACP
# The CPB
# The DOJ
# The EIS
# The NAHB
# The GLOBE
# The AHEC
# The IMF
# The GEF
# The TDA
# The CHAIR
# The TTBT
# The IAEA
# The NIH
# The OSHA
# The CDC
# The MOU
# The AES
# The PRC
# The FIRST
# The GPO
# The JCP
# The CRS
# The ACTING
# The FTUI
# The IRI
# The HELMS

