require 'rubygems'
require 'stemmify'
require 'pry'
require 'statsample'

task :regression => :environment do
  year = 2012
  ids = Phrase.where(:year => 2012).order('chi2 DESC').limit(100)
  freq_total = Hash.new 
  scorehash = Hash.new
  Speaker.all.each {|speaker| 
  	freq_total["#{speaker.id}"] = 1
  	scorehash["#{speaker.id}"] = speaker.score
  }
puts(freq_total)
puts(scorehash)
  Occurence.select('count(phrase_id) as number, speaker_id').where(:phrase_id => ids).group(:speaker_id).each {|a| 
  	freq_total["#{a.speaker_id}"] = a.number
  }
puts(freq_total)
  ids.each {|phrase|
  	freq = []
  	score = []
  	puts(phrase.id)
  	Speaker.all.each{|sp|
  		freq = freq << (sp.occurences.where(:phrase_id => phrase.id).count.to_f)/(freq_total["#{sp.id}"].to_f)
  		score = score << scorehash["#{sp.id}"]
  	}
  	y = freq.to_scale
	x = score.to_scale
	sr=Statsample::Regression.simple(x,y)
	phrase.create_result(:intercept => sr.a, :slope => sr.b)
	puts(phrase.text)
	puts(sr.b)
  }


# 		ds = {'a' => score.to_scale, 'b' => score2.to_scale, 'y' => frequency.to_scale}.to_dataset
# 		puts(ds)
# 		lr=Statsample::Regression.multiple(ds,'y')
# 		puts(phrase.text)
# 		puts(lr.a)
# 		2001 Editor and Publisher (E&P) International Yearbook
# ADD COLUMN - R SQUARED
# 		phrase.create_result(:intercept => sr.a, :slope => sr.b)
    
end