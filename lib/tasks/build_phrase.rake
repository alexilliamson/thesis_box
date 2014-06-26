require 'rubygems'
require 'stemmify'
require 'pry'

task :build_phrase => :environment do
  puts(Time::now)
  [1994,2012].each {|year|
    Use.find_each(:readonly => false, :start => 6288738) {|use|
    @phrase = use.text.split[0].stem + use.text.split[1].stem + use.text.split[2].stem
    @new = Phrase.find_or_create_by_stem(:stem => @phrase)
    use.assign_attributes(:phrase_id => @new.id)
    use.save

    if use.id % 10000 == 0
      puts(use.id)
    end
  }
  }
  puts(Time::now)



    
end
