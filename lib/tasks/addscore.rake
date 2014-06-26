require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore => :environment do
  counter = 0
  puts(Time::now)
#   year = 1994


#   @rtotal = Phrase.joins(:speakers).where(:speakers => {:party =>'R', :year => year} ).count.to_f
#   @dtotal = Phrase.joins(:speakers).where(:speakers => {:party =>'D', :year => year} ).count.to_f
#   puts(@rtotal)
#   puts(@dtotal)
#   puts(Time::now)

#   Phrase.find_each {|phrase|
#     @fr = (phrase.speakers.where(:party => 'R', :year => year)).count.to_f
#     @fd = (phrase.speakers.where(:party => 'D', :year => year)).count.to_f
#     @nfr = @rtotal - @fr
#     @nfd = @dtotal - @fd
#     @chi2 = ((@fr*@nfd - @fd*@nfr)**2)/((@fr+@fd)*(@fr+@nfr)*(@fd+@nfd)*(@nfr+@nfd)).to_f
#     if @chi2 > 0.0
#       phrase.assign_attributes(:chi2 => @chi2)
#       phrase.save
#       counter += 1
#     end
#     if counter % 10000 == 0
#       puts (counter)
#     end

# }

    counter = 0
  puts(Time::now)
  year = 2012


  @rtotal = Phrase.joins(:speakers).where(:speakers => {:party =>'R', :year => year} ).count.to_f
  @dtotal = Phrase.joins(:speakers).where(:speakers => {:party =>'D', :year => year} ).count.to_f
  puts(@rtotal)
  puts(@dtotal)
  puts(Time::now)

  Phrase.find_each {|phrase|
    @fr = (phrase.speakers.where(:party => 'R', :year => year)).count.to_f
    @fd = (phrase.speakers.where(:party => 'D', :year => year)).count.to_f
    @nfr = @rtotal - @fr
    @nfd = @dtotal - @fd
    @chi2b = ((@fr*@nfd - @fd*@nfr)**2)/((@fr+@fd)*(@fr+@nfr)*(@fd+@nfd)*(@nfr+@nfd)).to_f
    if @chi2b > 0.0
      phrase.assign_attributes(:chi2b => @chi2b)
      phrase.save
      counter += 1
    end
    if counter % 10000 == 0
      puts (counter)
    end

}
  puts(Time::now)



    
end
