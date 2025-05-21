# Appium Logging in OnTop Project

## Overview
This document explains how Appium handles logging in the OnTop project, particularly focusing on the Android logcat capture functionality.

## Logcat Capture
When running tests with Appium against Android devices or emulators, you may notice messages in the Appium logs like:
- "Starting logcat capture"
- "Stopping logcat capture"

### What is logcat?
Logcat is Android's logging system that allows viewing system and application messages. It provides valuable debugging information during test execution.

### Appium's Logcat Capture
- **Starting logcat capture**: When an Appium session starts, Appium automatically begins capturing Android logcat logs.
- **Stopping logcat capture**: When an Appium session ends or is terminated, Appium stops capturing logcat logs.

### Important Notes
1. The message "Stopping logcat capture" in the Appium logs is **normal behavior** and not an error condition.
2. This is a built-in feature of Appium for Android and helps with debugging.
3. No configuration is needed in the OnTop project to enable or disable this feature, as it's handled automatically by Appium.

## Accessing Logcat Logs
By default, Appium stores the captured logcat logs in its internal buffer. If you need to access these logs for debugging:

1. You can view them in the Appium server console output
2. You can retrieve them programmatically using Appium's API if needed

## Related Files in OnTop Project
The following files contain documentation about Appium logging:
- `Resources/Utils/Mobile_Mgmt_Direct.py`
- `Resources/Utils/Mobile_Mgmt.resource`

## Further Reading
- [Appium Documentation](https://appium.io/docs/en/latest/)
- [Android Logcat Documentation](https://developer.android.com/studio/command-line/logcat)