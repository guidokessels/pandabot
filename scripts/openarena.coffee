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
#   hubot show Open Arena stats
#   hubot show Open Arena toplist

oa_server_ip = '46.21.162.135:1200'
oa_api_url = 'https://quake.ijohan.nl'

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
        names.push count + '. ' + name
        count = count + 1
      cb(names)

grab_current_player_list = (msg, cb) ->
  msg.http(oa_api_url + '/players/live')
    .header('User-Agent', 'Mozilla/5.0')
    .get() (err, res, body) ->
      result = JSON.parse body
      cb(result.players)

module.exports = (robot) ->
    robot.respond /show (OA|Open Arena|Arena|Quake)( server)? (banner|stats|statistics)/i, (msg) ->
        msg.send 'http://cache.www.gametracker.com/server_info/' + oa_server_ip + '/banner_560x95.png?random=' + Math.random()

    robot.respond /show (OA|Open Arena|Arena|Quake) (ladder|top|highscore|score)? ?list/i, (msg) ->
        grab_top_players msg, (names) ->
            msg.send "The top 10 players are:\n    " + names.join('\n    ')

    robot.hear /who('?s| is)( currently| now)? playing (OA|Open Arena|Arena|Quake)/i, (msg) ->
        grab_current_player_list msg, (result) ->
            count = result.length
            playernames = []

            result.forEach (player) ->
              playernames.push player.name

            if count > 1
              players = 'people are'
            else 
              players = 'person is'

            if count < 1
              msg.send "No-one is currently playing :-("
            else
              msg.send count + " " + players + " currently playing:\n    " + playernames.join("\n    ")
