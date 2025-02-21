@echo off
title Appium-Server
start cmd /k "appium --allow-cors  --base-path /wd/hub"

REM https://appium.io/docs/en/latest/cli/args/