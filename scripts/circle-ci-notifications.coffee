watchers = {
  "besu": {
    channel: "besu-contributors"
    regexes: [
      /master/
      /release-.*/
    ]
  }
}

CIRCLE_NOTIFICATION_PREFIX = 'circle-ci-notify'

module.exports = (robot) ->
  robot.router.post '/hubot/circleci', (req, res) ->
    payload = req.body.payload
    branch = payload.branch.toLowerCase()
    repo = payload.reponame.toLowerCase()
    jobName = payload.workflows.job_name
    currentResult = payload.outcome.toUpperCase()

    robot.logger.debug "Starting checks of #{repo}/#{branch}-#{jobName} with status #{currentResult}"

    if ! watchers[repo].regexes.some((rx) -> rx.test(branch))
      robot.logger.debug "No channels care about #{repo}/#{branch}"
      return res.send 'No channels care about this build'

    brainKey = "#{CIRCLE_NOTIFICATION_PREFIX}-#{repo}-#{branch}-#{jobName}"

    lastResult = robot.brain.get(brainKey)
    robot.logger.debug "Last result was #{lastResult}, current result is #{currentResult}"
    robot.brain.set(brainKey, currentResult)

    if currentResult != "SUCCESS"
      message = "#{jobName} for #{repo} - #{branch} : #{currentResult}. See more at `#{payload.build_url}`"
      robot.send {room: watchers[repo].channel}, message
      res.send 'Users alerted of build status.'
    else if lastResult? and lastResult != currentResult and currentResult == "SUCESS"
      message = "#{jobName} for #{repo} - #{branch} has recovered"
      robot.send {room: watchers[repo].channel}, message
      res.send 'Users alerted of build status.'
