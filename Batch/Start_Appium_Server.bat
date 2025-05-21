@echo off
title Appium-Server
start cmd /k "appium --allow-cors  --base-path /wd/hub --log appium.log"

REM https://appium.io/docs/en/latest/cli/args/