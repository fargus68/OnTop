@echo off
title Appium-Server
start cmd /k "appium --relaxed-security --allow-cors --allow-insecure chromedriver_autodownload --log appium.log"

REM https://appium.io/docs/en/latest/cli/args/