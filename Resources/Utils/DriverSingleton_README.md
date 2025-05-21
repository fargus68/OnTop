# Driver Singleton Implementation

This document explains the Singleton implementation for managing the Appium driver instance in the OnTop project.

## Problem

The original implementation in `Mobile_Mgmt_Direct.py` uses a global variable `_driver` to maintain the Appium driver state. When this module is imported in multiple places (either in different Robot files or in Python modules that are then imported by Robot), each import creates a different instance of the module, each with its own copy of the global variables.

This can lead to issues where:
1. One module sets the driver, but another module doesn't see the change
2. Multiple driver instances are created, wasting resources
3. Operations on the driver in one module don't affect the driver in another module

## Solution

The solution is to implement a Singleton pattern for the driver management. A Singleton ensures that only one instance of a class is created and shared across all imports.

### Files

1. **`DriverSingleton.py`**: The core Singleton implementation that encapsulates the driver instance and provides methods to access and manipulate it.
2. **`DriverSingletonAdapter.py`**: A compatibility layer that exposes functions with the same names and signatures as those in `Mobile_Mgmt_Direct.py`, but internally uses the Singleton class.
3. **`DriverSingleton_Example.py`**: Examples demonstrating how to use the Singleton class and adapter.

## How to Use

### Option 1: Direct Usage (Recommended for New Code)

```python
from Resources.Utils.DriverSingleton import DriverSingleton

# Create a singleton instance (this will always return the same instance)
singleton = DriverSingleton()

# Get the driver instance
driver = singleton.get_driver()

# Use other methods of the singleton
singleton.wait_until_login_screen_is_ready()
singleton.restart_application()
```

### Option 2: Using the Adapter (Recommended for Existing Code)

Simply replace imports from `Mobile_Mgmt_Direct.py` with imports from `DriverSingletonAdapter.py`:

```python
# Before
from Resources.Utils.Mobile_Mgmt_Direct import get_driver, get_current_session

# After
from Resources.Utils.DriverSingletonAdapter import get_driver, get_current_session
```

No other changes are needed! The adapter functions have the same signatures and behavior as the original functions.

### In Robot Framework Files

```robotframework
*** Settings ***
# Before
Library    ../../Resources/Utils/Mobile_Mgmt_Direct.py    WITH NAME    SessionHelper

# After
Library    ../../Resources/Utils/DriverSingletonAdapter.py    WITH NAME    SessionHelper
```

## Benefits

1. **Shared State**: All modules that import the Singleton or adapter will share the same driver instance.
2. **Resource Efficiency**: Only one driver instance is created, reducing resource usage.
3. **Consistency**: Operations on the driver in one module will affect the driver in all modules.
4. **No Code Changes**: Existing code can use the adapter without any modifications.

## Implementation Details

The Singleton pattern is implemented using the `__new__` method to ensure only one instance of the class is created:

```python
class DriverSingleton:
    # Class variable to hold the singleton instance
    _instance = None
    
    # Class variable to hold the driver instance
    _driver = None
    
    def __new__(cls):
        """
        Ensure only one instance of DriverSingleton is created.
        """
        if cls._instance is None:
            cls._instance = super(DriverSingleton, cls).__new__(cls)
        return cls._instance
```

The adapter functions simply delegate to the Singleton instance:

```python
# Create a singleton instance
_singleton = DriverSingleton()

def get_driver():
    return _singleton.get_driver()

def get_current_session():
    return _singleton.get_driver()
```

## Conclusion

This Singleton implementation provides a robust solution to the driver management problem without requiring changes to existing code. It ensures that all modules share the same driver instance, improving consistency and resource efficiency.