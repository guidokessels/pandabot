# Description:
#   Hubot, be polite and say goodbye.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Goodbye
#   Bye
#   Byebye
#   Bye bye
#   See you|u tomorrow|2morrow|later|next week
byebye = [
    "Bye, %",
    "Have a nice day, %",
    "Ciao! %",
    "See you, %",
    "% has left the building",
    "Noooo, don't leave me, %!",
    "Bye bye!",
    "Goodbye, %"
]
module.exports = (robot) ->
    robot.hear /^(good)?(bye( )?(bye)?)/i, (msg) ->
        bye = msg.random byebye
        msg.send bye.replace "%", msg.message.user.name

    robot.hear /(^see (you|u)( )?(tomorrow|2morrow|later|next week)?)/i, (msg) ->
        bye = msg.random byebye
        msg.send bye.replace "%", msg.message.user.name