rem
rem SPDX-License-Identifier: Apache-2.0
rem

@echo off

call npm install
SETLOCAL
SET PATH=node_modules\.bin;node_modules\hubot\node_modules\.bin;%PATH%

node_modules\.bin\hubot.cmd --name "hyperledger-bot" %*
