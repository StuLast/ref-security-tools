# NPM Hunter

Use this shell script to hunt for node modules which have been mentioned in security briefings.

Currently the suspect modules are listed in an array withing the script, and the script will only analyse from the directory it's in, and all subfolder s.

Issues occur when the script is run in machine root (permissions)

The tool is completely free of downloaded external libraries, and recursively drills down through a project file structure analysing the package.json file for module names.

Currently no report is generated, but any packages discovered that are in the list are output as full paths.

## Usage

The script can be downloaded as part of the clone of this github repo.  You can run the script from anywhere as it will ask you to define the path you want as the top level of your recursive search.  For example, if you have all your projects in a root level projects folder, you can run the script and enter ../projects.  The path only has to be relative from where you've cloned the security-tools repo.  You can of course use absolute paths instead.  Both will work.

Run `bash npmhunter.sh` from the terminal on Linux and Mac, or from WSL on Windows.

Enter the path you want to run the script on.

Script will show  progress in the terminal/shell when it starts and, when it's complete, it will show the results of the scan.
If any suspicious node modules have been found, these will be output along with the path to where they were found



## Roadmap

 - Improve terminal output to show progress, and to show clear results.
 - Implement scanning using an external file as the source instead of hardcoded array
 - Implement user input of a folder path
 - Implement usability from root/home
 - Implement output as a txt file.
 
