@echo off
title Appium-Server
start cmd /k "appium --allow-cors --allow-insecure chromedriver_autodownload"

REM https://appium.io/docs/en/latest/cli/args/