info = IO.readlines("dw_nom.csv")
file = File.new("DWscore.txt", "w")
info.each_index {|n| 
	info[n] = info[n].split(',')
	info[n][3] = info[n][3].split[0]
}

info.each {|line| 
	edits = info.select {|person| person[3] == line[3] && person[0] == line[0]}
	puts edits.size
	# edits.each{|edit|
	# 	edit[3] = edit[3] + "of #{edit[1].downcase.capitalize}"}
}




# speaker = Speaker.find_or_create_by_name_and_year(:name => info[a][4], :year => ((info[a][1].to_i-103)*2 + 1994)