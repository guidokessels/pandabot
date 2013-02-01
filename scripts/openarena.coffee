# Description:
#   Script to gather stats from the Spil OA server
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   show Open Arena stats
#   show Open Arena toplist

oa_server_ip = '46.21.162.135:1200'

top_players_regexp = /<td class="c02">(?:\n)?(?:\s+)?<a href="\/player\/(?:.*)">(.*)</g

grab_top_players = (msg, cb) ->
  msg.http('http://www.gametracker.com/server_info/' + oa_server_ip + '/top_players/')
    .header('User-Agent', 'Mozilla/5.0')
    .get() (err, res, body) ->
      names = []
      count = 1;
      matches = body.match top_players_regexp 
      matches.forEach (line) ->
        name = line.replace top_players_regexp, '$1' 
        names.push '#' + count + '. ' + name
        count = count + 1
      cb(names)

module.exports = (robot) ->
    robot.respond /show (OA|Open Arena|Arena|Quake)( server)? (banner|stats|statistics)/i, (msg) ->
        msg.send 'http://cache.www.gametracker.com/server_info/' + oa_server_ip + '/banner_560x95.png?random=' + Math.random()

    robot.respond /show (OA|Open Arena|Arena|Quake) (ladder|top|highscore|score)? ?list/i, (msg) ->
        grab_top_players msg, (names) ->
            msg.send "The top 10 players are:\n  " + names.join('\n  ')
