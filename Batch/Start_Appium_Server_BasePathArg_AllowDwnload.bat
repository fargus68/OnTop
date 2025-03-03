@echo off
title Appium-Server
start cmd /k "appium --allow-cors --allow-insecure chromedriver_autodownload --base-path /wd/hub"

REM https://appium.io/docs/en/latest/cli/args/