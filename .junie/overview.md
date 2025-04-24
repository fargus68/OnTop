# OnTop Project Overview

## Project Description
OnTop is a test automation framework built on top of Robot Framework (hence the name "OnTop"). The primary goal is to achieve a strong decoupling of test data from code, particularly for GUI automation. Instead of coding against specific controls, the framework targets control types, making it more maintainable and adaptable to changes.

## Key Features
- **Data-Driven Approach**: Uses Excel sheets for storing all test data, including workflow data and technical information
- **Layered Architecture**: Organizes tests in multiple levels (dialogs, processes, workflows)
- **Control Type Abstraction**: Interacts with UI elements based on control types rather than specific controls
- **Redundancy Reduction**: Implements mechanisms to keep test data redundancy-free
- **Cross-Platform**: Supports web and mobile application testing (including Appium integration)

## Project Structure
- **Libraries/**: Contains helper modules for various functionalities
  - Appium integration
  - Table handling
  - Date/time operations
  - Element interactions
  - Session management
  - Window management
  - Record reading
  - And more

- **Resources/**: Framework resources
  - Controls: Control-specific implementations
  - Framework: Core framework components
  - Helper: Helper utilities
  - Keywords: Robot Framework keywords
  - Locators: Element locators
  - PageObjects: Page object models
  - Utils: Utility functions

- **Tests/**: Test implementations for multiple applications
  - Sports club/team management application (001-009, 021-022)
  - Insurance application with different insurance types (101-105)

## When to Use OnTop
This framework is particularly beneficial for:
- Applications with many dialogs using the same control set
- Administrative software managing various data in a similar way
- Applications with expected long lifespans and frequent changes
- Projects anticipating technology updates or technology changes
- System tests requiring data verification across multiple applications or interfaces

## Technical Implementation
- **Execution Layer**: Verifies the system under test is in the correct state and distributes action information to the generic control code
- **Processing Layer**: Reads Excel files sequentially until reaching a point where action against the system under test is required
- **Logging**: Includes both technical and business-oriented logging
- **Additional Tooling**: Dialog scanners, consistency checkers, etc.

## More Information
Videos about this project can be found on the author's homepage: https://matthias-schmotz.eu/tools