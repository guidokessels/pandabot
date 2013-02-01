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
#   None
#   
byebye_messages = [
    "Bye, %!",
    "Have a nice day, %.",
    "Ciao, %!",
    "See you, %.",
    "% has left the building!",
    "Noooo, don't leave me, %!",
    "Bye bye!",
    "Goodbye, %."
]

module.exports = (robot) ->
    robot.hear /(^(good)?( )?bye( )?(bye)?( )?(.*)?)/i, (msg) ->
        bye = msg.random byebye_messages
        msg.send bye.replace "%", msg.message.user.name

    robot.hear /(^see (you|ya|u)( .*)?)/i, (msg) ->
        bye = msg.random byebye_messages
        msg.send bye.replace "%", msg.message.user.name