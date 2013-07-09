#!/usr/bin/env python

#NAME
#	mlbscores - report baseball scores in realtime by reading the ESPN MLB scoreboard webpage
#SYNOPSIS
#	mlbscores [team]
#DESCRIPTION
#	run the script with no arguments to see all the scores
#	run the script with one argument to only show games with teams with that phrase in their name participating (case insensitive)
#	team names are as they appear on the ESPN website (city names actually, and/or team names if ambiguous)
#	the special phrase 'all' will show all games (useful when default team is hardcoded)
#	use watch for realtime updates
#BUGS
#	python's sgmllib.SGMLParser complains about ESPN's webpage as late as python 2.2.3
#	I've seen ESPN put a 0 in the top of the 1st for a postponed game, making it appear as if it's in progress (this 0 is not rendered in a web browser)
#	obviously, if ESPN changes their webpage enough, it will break this script


import sgmllib, copy, sys


def rpad(text, length, char=' '): return text+char*(length-len(text))
def lpad(text, length, char=' '): return char*(length-len(text))+text


class ESPNMLBScoresParser(sgmllib.SGMLParser):
	#game data is stored like [['Away Team', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'R', 'H', 'E'], ['Home Team', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'R', 'H', 'E']]
	#1..9 are the runs scored that inning, and RHE are the respective totals
	#everything is a string (all numeric, except 1..9 entries may be '' (inning no yet completed) or 'X' (bottom of the 9th not played))
	#the data is filled in by first creating all entries as '', then filling them in one by one as they're reached when parsing the html source
	#self.getGames() returns a list of these game data strutures
	#notes on ESPN html code
	#	<div class=gameContainer> starts a game
	#	<td class=teamLine>, first <a>'s data after that is away team name
	#	<td class=teamLine>, first <a>'s data after that is home team name
	#	<td class=innLine> x9, data are away runs for each inning
	#	<td class=innLine> x9, data are home runs for each inning
	#	<td class=rheLine> x3, data are away RHE
	#	<td class=rheLine> x3, data are home RHE
	
	def __init__(self):
		sgmllib.SGMLParser.__init__(self)
		
		#sgmllib.SGMLParser complains about ESPN's page as late as 2.2.3, but doesn't as early as 2.3.3 (I don't know about anything between)
		verReq = [2,3,3]
		verSys = [sys.version_info[0],sys.version_info[1],sys.version_info[2]]
		if verSys<verReq:
			print '*** ERROR *** You are using Python '+'.'.join(map(str,verSys))+'.  This script requires Python >= '+'.'.join(map(str,verReq))+'.'
			sys.exit(1)
	
	def _reset_vars(self):
		self.next_a_is_away_team = False
		self.next_a_is_home_team = False

		self.next_data_is_stat = False
		
		self.team_index = 0  #0 ~ away, 1 ~ home
		self.stat_index = 0  #0 ~ team name, 1..9 ~ runs in each inning, 10-12 ~ RHE

		self.in_a               = False
		self.in_td_that_matters = False

		self.end_game = False

	def reset(self):
		sgmllib.SGMLParser.reset(self)
		
		self.games = []
		self._reset_vars()
	
	def start_div(self, atts):
		for name, value in atts:
			if name=='class' and value=='gameContainer':
				self._reset_vars()
				self.games.append([['']*13,['']*13])
				break
	
	def start_td(self, atts):
		for name, value in atts:
			if name=='class':
				if value=='teamLine':
					if   not self.games[-1][0][0]: self.next_a_is_away_team = True
					elif not self.games[-1][1][0]: self.next_a_is_home_team = True
					break
				if value in ['innLine', 'rheLine']:
					self.in_td_that_matters = True
					
					#self.team_index and self.stat_index now point to where the last thing went; make them point to where the next thing will go
					if self.stat_index==9:
						if self.team_index==0:
							self.team_index = 1
							self.stat_index = 1
						else:
							self.team_index =  0
							self.stat_index = 10
					elif self.stat_index==12 and self.team_index==0:
							self.team_index =  1
							self.stat_index = 10
					elif self.stat_index==11 and self.team_index==1:
							self.stat_index = 12
							self.end_game = True
					else:
						self.stat_index += 1
					break
	def end_td(self): self.in_td_that_matters = False
	
	def start_a(self, atts): self.in_a = True
	def end_a(self)        : self.in_a = False
	
	def handle_data(self, data):
		if self.in_a:
			if self.next_a_is_away_team:
				self.games[-1][0][0] = data
				self.next_a_is_away_team = False
				return
			if self.next_a_is_home_team:
				self.games[-1][1][0] = data
				self.next_a_is_home_team = False
				return
		if self.in_td_that_matters:
			self.games[-1][self.team_index][self.stat_index] = data
			if self.end_game: self._reset_vars()
	
	def getGames(self): return copy.deepcopy(self.games)


if __name__=='__main__':
	import sys, urllib2

	parser = ESPNMLBScoresParser()
	parser.reset()
	parser.feed(urllib2.urlopen('http://sports.espn.go.com/mlb/scoreboard').read())
	parser.close()
	
	games = parser.getGames()

	qry = 'CLE'  # <-- put your favorite team here
	if len(sys.argv)>1: qry = sys.argv[1]
	if qry.lower()=='all': qry = ''
	games = filter(lambda game: qry.lower() in game[0][0].lower() or qry.lower() in game[1][0].lower(), games)
	if len(games)==0:
		print '*** ERROR *** No teams match ['+qry+'].'
		sys.exit(1)

	team_width = max(map(len, [game[0][0] for game in games]+[game[1][0] for game in games]))
	for game in games:
		print lpad('', team_width+1),
		for i in range(1,10): print rpad(`i`, 2),
		print ' ',
		print 'R  H  E',
		print

		for i in range(2):
			print rpad(game[i][0], team_width),
			for j in range( 1,10): print lpad(game[i][j], 2),
			print ' ',
			for j in range(10,13): print lpad(game[i][j], 2),
			print
		
		if len(games)!=1: print
