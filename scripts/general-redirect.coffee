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
  /fabric-ca/i
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

module.exports = (robot) ->
  robot.logger.info "Redirect script is running"

  # redirect user to the specified channel
  redirectTo = (res, channel) ->
    res.reply "Please redirect your question to ##{channel}"
    robot.logger.info "*** Redirected to #{channel} ***"

  # Handle #fabric-questions
  robot.listen(
    (message) -> # Add regular expressions for #fabric-questions above
      message.room is "general" and fabricQuestionsRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "fabric-questions"
  )

  # Handle #sawtooth
  robot.listen(
    (message) -> # Add regular expressions for #sawtooth above
      message.room is "general" and sawtoothRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "sawtooth"
  )

  # Handle #sawtooth-seth
  robot.listen(
    (message) -> # Add regular expressions for #sawtooth above
      message.room is "general" and sawtoothSethRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "sawtooth-seth"
  )

  # Handle #composer
  robot.listen(
    (message) -> # Add regular expressions for #composer above
      message.room is "general" and composerRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "composer"
  )

  # Handle #iroha
  robot.listen(
    (message) -> # Add regular expressions for #iroha above
      message.room is "general" and irohaRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "iroha"
  )

  # Handle #burrow
  robot.listen(
    (message) -> # Add regular expressions for #burrow above
      message.room is "general" and burrowRegEx.some((rx) -> rx.test(message))
    (response) -> # Standard listener callback
      redirectTo response, "burrow"
  )
