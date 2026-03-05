# GCP Log Analysis
This tool, in it's current form, will take a GCP log download (json format), crunch the data and output a new JSON file with unique lists of URLs and requesting IP addresses.

This was originally created to analyse cloud logs that indicate scans for credential files, and the resultant questionable IPs.  This information can than act as a basis for further examination and/or mitigating measures to enhance our security posture.

## Usage:

use `node main.js ./path/to/file` from the root of this folder, followed by the path to a file you wish to analyse.  A folder ./input-json is provided to make this a bit more organised, but any path will work

The console will let you know the volume which has been analysed.  The resulting analyis JSON file is output to ./output.json, and the full path is shown in the console output.