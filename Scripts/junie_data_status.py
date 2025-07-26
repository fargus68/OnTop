import os
import datetime
import sys
from pathlib import Path

def get_junie_data_status():
    """
    Get the status of Junie's data stock by checking the last modification time
    of Junie-related files.
    
    Returns:
        dict: A dictionary containing information about Junie's data stock
    """
    junie_dir = Path('.junie')
    
    if not junie_dir.exists():
        print("Junie data directory not found. Junie may not be initialized for this project.")
        return None
    
    status = {
        'junie_dir_exists': junie_dir.exists(),
        'files': []
    }
    
    # Check all files in the .junie directory
    if junie_dir.exists():
        for file_path in junie_dir.glob('**/*'):
            if file_path.is_file():
                file_info = {
                    'path': str(file_path),
                    'last_modified': datetime.datetime.fromtimestamp(file_path.stat().st_mtime),
                    'size': file_path.stat().st_size
                }
                status['files'].append(file_info)
    
    # Sort files by last modified time (newest first)
    status['files'].sort(key=lambda x: x['last_modified'], reverse=True)
    
    # Calculate overall status
    if status['files']:
        status['newest_file'] = status['files'][0]
        status['oldest_file'] = status['files'][-1]
        status['total_files'] = len(status['files'])
        
        # Calculate how recent the data is
        now = datetime.datetime.now()
        newest_file_age = now - status['newest_file']['last_modified']
        status['newest_file_age_days'] = newest_file_age.days
        status['newest_file_age_hours'] = newest_file_age.seconds // 3600
        
        # Determine if data is current (less than 7 days old)
        status['is_current'] = newest_file_age.days < 7
    
    return status

def print_junie_data_status():
    """Print the status of Junie's data stock in a human-readable format."""
    status = get_junie_data_status()
    
    if not status:
        return
    
    print("\n=== Junie Data Stock Status ===")
    
    if not status['files']:
        print("No Junie data files found.")
        return
    
    # Print overall status
    print(f"Total Junie data files: {status['total_files']}")
    
    newest_file = status['newest_file']
    print(f"\nMost recent data:")
    print(f"  File: {newest_file['path']}")
    print(f"  Last modified: {newest_file['last_modified'].strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"  Age: {status['newest_file_age_days']} days, {status['newest_file_age_hours']} hours")
    
    if status['is_current']:
        print("\nStatus: CURRENT - Junie data is up-to-date (less than 7 days old)")
    else:
        print("\nStatus: OUTDATED - Junie data is more than 7 days old")
        print("Recommendation: Consider refreshing Junie's knowledge of the project")
        print("  - In PyCharm, you can use the Junie tool window to refresh the project")
        print("  - Or use Junie commands to interact with the project and update its knowledge")
    
    print("\nAll Junie data files:")
    for i, file_info in enumerate(status['files'], 1):
        print(f"  {i}. {file_info['path']}")
        print(f"     Last modified: {file_info['last_modified'].strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"     Size: {file_info['size']} bytes")

if __name__ == "__main__":
    print_junie_data_status()