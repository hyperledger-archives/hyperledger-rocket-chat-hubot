# Will send redirect users to a channel based on what it hears.

fabricQuestionsRegEx = [
  /byfn/i,
  /orderer/i,
  /ordering service/i,
  /fabric-samples/i,
  /configtx/i,
  /chaincode/i,
  /endorser/i,
  /endorsement/i,
  /configtxgen/i,
  /msp/i,
  /create_channel.sh/i,
  /core.yaml/i,
  /stub.getQueryResult/i,
  /fabric questions/i,
  /hyperledger fabric/i,
  /fabric-ca/i,
  /crypto-config.yaml/i
]

sawtoothRegEx = [
  /[^#]sawtooth/i,
  /poet/i,
  /transaction processor/i,
  /transaction family/i,
  /validator.toml/i
]

sawtoothSethRegEx = [
  /seth/i
]

composerRegEx = [
  /createPeerAdminCard/i,
  /getAssetRegistry/i,
  /getParticipantRegistry/i,
  /business network archive/i,
  /bna/i,
  /[^#]composer/i
]

irohaRegEx = [
  /[^#]iroha/i
]

burrowRegEx = [
  /[^#]burrow/i
]

experts = [
  "tkuhrt",
  "Dan",
  "ry",
  "yacovm",
  "zac",
  "nickgaski",
  "mastersingh24",
  "cbf",
  "lehors",
  "jsmitchell",
  "amundson"
]

# Which rooms should I respond in. Shell is for testing from command line.
rooms = [
  "Shell",
  "general"
]

module.exports = (robot) ->
  robot.logger.info "Redirect script is running"

  # redirect user to the specified channel
  redirectTo = (res, channel) ->
    res.reply "Please redirect your question to ##{channel}"
    robot.logger.info "*** Redirected to #{channel} ***"

  # should the bot respond? returns true/false
  #  - Must be in one of the rooms specified
  #  - Must not be an expert (unless they are testing hubot)
  #  - Message must match one of the regular expressions
  respondTo = (msg, regEx) ->
    msg.room in rooms and
    (msg.user.name not in experts or /test/i.test(msg)) and
    regEx.some((rx) -> rx.test(msg))

  # Handle #fabric-questions
  robot.listen(
    (message) -> # Add regular expressions for #fabric-questions above
      respondTo(message, fabricQuestionsRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "fabric-questions"
  )

  # Handle #sawtooth
  robot.listen(
    (message) -> # Add regular expressions for #sawtooth above
      respondTo(message, sawtoothRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "sawtooth"
  )

  # Handle #sawtooth-seth
  robot.listen(
    (message) -> # Add regular expressions for #sawtooth above
      respondTo(message, sawtoothSethRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "sawtooth-seth"
  )

  # Handle #composer
  robot.listen(
    (message) -> # Add regular expressions for #composer above
      respondTo(message, composerRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "composer"
  )

  # Handle #iroha
  robot.listen(
    (message) -> # Add regular expressions for #iroha above
      respondTo(message, irohaRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "iroha"
  )

  # Handle #burrow
  robot.listen(
    (message) -> # Add regular expressions for #burrow above
      respondTo(message, burrowRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "burrow"
  )
