@echo off
title Appium-Server
start cmd /k "appium --allow-cors --allow-insecure chromedriver_autodownload --base-path /wd/hub --log appium.log"

REM https://appium.io/docs/en/latest/cli/args/