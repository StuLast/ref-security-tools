# Check Next/React versions

This tool checks the package.json file in the directory tree for the existence of the next and react libraries.  It then checks the version and reports back if Next is of the 14.x.x range, or React is of the the 19.x.x range.  Any NextJS or React modules are reported back.

## Usage

1.  Download the repo to a convenient folder.
2.  Using the command line, change the permissions for check-net-react-versions.sh to executable `chown 755 ./check-next-react-versions.sh`
3.  Run the shell script, passing in the path you want to analyse ` ./check-next-react-versions.sh ../path/to/folder/to/analyse`
