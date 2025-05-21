"""
Driver Singleton Example

This module demonstrates how to use the DriverSingleton class and the DriverSingletonAdapter.

There are two ways to use the Singleton pattern:

1. Direct usage of the DriverSingleton class:
   This is recommended for new code or when refactoring existing code.

2. Using the DriverSingletonAdapter:
   This provides a drop-in replacement for code that currently imports from Mobile_Mgmt_Direct.py.

Both approaches ensure that only one driver instance is created and shared across all imports.
"""

# Example 1: Direct usage of DriverSingleton
def example_direct_usage():
    print("\n=== Example 1: Direct usage of DriverSingleton ===")
    
    # Import the DriverSingleton class
    from Resources.Utils.DriverSingleton import DriverSingleton
    
    # Create a singleton instance (this will always return the same instance)
    singleton = DriverSingleton()
    
    # Get the driver instance
    driver = singleton.get_driver()
    print(f"Driver session ID: {driver.session_id}")
    
    # Create another singleton instance (this will return the same instance as before)
    another_singleton = DriverSingleton()
    
    # Verify that both instances are the same
    print(f"Are singleton instances the same? {singleton is another_singleton}")
    
    # Verify that both driver instances are the same
    another_driver = another_singleton.get_driver()
    print(f"Are driver instances the same? {driver is another_driver}")
    
    # Use other methods of the singleton
    singleton.log_status()
    singleton.get_session_info()

# Example 2: Using the DriverSingletonAdapter
def example_adapter_usage():
    print("\n=== Example 2: Using the DriverSingletonAdapter ===")
    
    # Import functions from the adapter instead of from Mobile_Mgmt_Direct.py
    from Resources.Utils.DriverSingletonAdapter import get_driver, get_current_session, log_status
    
    # Get the driver instance using the adapter functions
    driver = get_driver()
    print(f"Driver session ID: {driver.session_id}")
    
    # Get the current session (this will return the same driver instance)
    session = get_current_session()
    print(f"Session ID: {session.session_id}")
    
    # Verify that both instances are the same
    print(f"Are driver and session the same? {driver is session}")
    
    # Use other functions from the adapter
    log_status()

# Example 3: Mixing both approaches
def example_mixed_usage():
    print("\n=== Example 3: Mixing both approaches ===")
    
    # Import from both the DriverSingleton class and the adapter
    from Resources.Utils.DriverSingleton import DriverSingleton
    from Resources.Utils.DriverSingletonAdapter import get_current_session
    
    # Create a singleton instance
    singleton = DriverSingleton()
    driver = singleton.get_driver()
    print(f"Driver session ID from singleton: {driver.session_id}")
    
    # Get the current session using the adapter
    session = get_current_session()
    print(f"Session ID from adapter: {session.session_id}")
    
    # Verify that both instances are the same
    print(f"Are driver and session the same? {driver is session}")

# Example 4: Replacing imports in existing code
def example_replacing_imports():
    print("\n=== Example 4: Replacing imports in existing code ===")
    print("In your existing code, replace:")
    print("from Resources.Utils.Mobile_Mgmt_Direct import get_driver, get_current_session")
    print("with:")
    print("from Resources.Utils.DriverSingletonAdapter import get_driver, get_current_session")
    print("\nNo other changes are needed!")

if __name__ == "__main__":
    # Run all examples
    example_direct_usage()
    example_adapter_usage()
    example_mixed_usage()
    example_replacing_imports()