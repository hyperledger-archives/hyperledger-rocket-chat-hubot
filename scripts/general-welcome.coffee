# Will send direct message to user when they enter the room.
#
# Configuration:
#   WELCOME_MESSAGE String, what the bot says to new users
#
# Commands:
#   hyperledger-bot say welcome - Repeats the bot's welcome message

welcomeMessage = process.env.WELCOME_MESSAGE or "Welcome, I'm @#{ botName }. If you need help just reply with `help`"

module.exports = (robot) ->
  robot.logger.info "Welcome script is running, will send:"
  robot.logger.info "\"#{ welcomeMessage }\""

  # send welcome message directly if direct is true; otherwise,
  # sends to the channel
  welcomeUser = (res, direct = true) ->
    user = res.envelope.user.name
    if direct
      res.sendDirect welcomeMessage
    else
      res.send welcomeMessage
    robot.logger.info "*** Sent welcome message to #{user} ***"

  # on user first entering a room with the bot
  robot.enter (res) ->
    welcomeUser res, true

  # reply in current room if forced to say welcome
  robot.respond /say welcome/, (res) ->
    welcomeUser res, false
