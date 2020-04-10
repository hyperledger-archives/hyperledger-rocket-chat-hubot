# Will send redirect users to a channel based on what it hears.

besuRegEx = [
  /ETH/,
  /ETC/,
  /[^#]besu/i,
  /ethereum classic/i,
  /goerli/i,
  /kotti/i,
  /mainnet/i,
  /mordor/i,
  /rinkeby/i,
  /ropsten/i
]

burrowRegEx = [
  /[^#]burrow/i
]

caliperRegEx = [
  /[^#]caliper/i
]

celloRegEx = [
  /[^#]cello/i
]

ciPipelineRegEx = [
  /jenkins/i
]

fabricQuestionsRegEx = [
  /byfn/i,
  /chaincode/i,
  /configtx/i,
  /configtxgen/i,
  /core.yaml/i,
  /create_channel.sh/i,
  /crypto-config.yaml/i,
  /endorsement/i,
  /endorser/i,
  /[^#]fabric/i,
  /fabric questions/i,
  /fabric-ca/i,
  /fabric-samples/i,
  /hyperledger fabric/i,
  /msp/i,
  /orderer/i,
  /ordering service/i,
  /stub.getQueryResult/i,
  /HLF/i
]

indyRegEx = [
  /[^#]indy/i
]

irohaRegEx = [
  /[^#]iroha/i
]

sawtoothRegEx = [
  /poet/i,
  /[^#]sawtooth/i,
  /transaction processor/i,
  /transaction family/i,
  /validator.toml/i
]

sawtoothSethRegEx = [
  /seth/i
]

experts = [
  "amundson",
  "cbf",
  "Dan",
  "dave.enyeart",
  "dbluhm",
  "faraggi",
  "guoger",
  "hartm",
  "heatherp",
  "jrosmith",
  "jsmitchell",
  "kdenhartog",
  "lehors",
  "MALodder",
  "mastersingh24",
  "nickgaski",
  "rjones",
  "shemnon",
  "sstone1",
  "swetha",
  "swcurran",
  "sykesm",
  "TelegramSam",
  "timbeiko",
  "tkuhrt",
  "xcr",
  "yacovm",
  "zac"
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
    res.reply "Please redirect your question to chat channel ##{channel}"
    robot.logger.info "*** Redirected to #{channel} ***"

  # should the bot respond? returns true/false
  #  - Must be in one of the rooms specified
  #  - Must not be an expert (unless they are testing hubot)
  #  - Message must match one of the regular expressions
  respondTo = (msg, regEx) ->
    msg.room in rooms and
    (msg.user.name not in experts or /TEST HUBOT/.test(msg.text)) and
    regEx.some((rx) -> rx.test(msg.text))

  # Handle #besu
  robot.listen(
    (message) -> # Add regular expressions for #besu above
      respondTo(message, besuQuestionsRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "besu"
  )

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

  # Handle #cello
  robot.listen(
    (message) -> # Add regular expressions for #cello above
      respondTo(message, celloRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "cello"
  )

  # Handle #caliper
  robot.listen(
    (message) -> # Add regular expressions for #caliper above
      respondTo(message, caliperRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "caliper"
  )

  # Handle #ci-pipeline
  robot.listen(
    (message) -> # Add regular expressions for #ci-pipeline above
      respondTo(message, ciPipelineRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "ci-pipeline"
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

  # Handle #indy
  robot.listen(
    (message) -> # Add regular expressions for #indy above
      respondTo(message, indyRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "indy"
  )

  # Handle #besu
  robot.listen(
    (message) -> # Add regular expressions for #besu above
      respondTo(message, besuRegEx)
    (response) -> # Standard listener callback
      redirectTo response, "besu"
  )
