const fs = require('fs');

const args = process.argv.slice(2);
if (args.length < 1) {
    console.error('Usage: node main.js <input-file>');
    process.exit(1);
}   
const inputFile = args[0];
console.log(`Input file: ${inputFile}`);
let jsonData;

const importData = () => {
    try {
        const rawData = fs.readFileSync(inputFile, 'utf8');
        jsonData = JSON.parse(rawData);
    } catch (err) {
        console.error(`Error reading or parsing file ${inputFile}:`, err);
        process.exit(1);
    }
    console.log('Data imported successfully.');
    console.log(`Total records imported: ${jsonData.length}`);
    console.log(`Error records: ${jsonData.filter(record => record.error).length}`);
}

const getUniqueIps = () => {
    const ipSet = new Set();
    jsonData.forEach(record => {
        if (record.httpRequest && record.httpRequest.remoteIp) {
            ipSet.add(record.httpRequest.remoteIp);
        }
    });
    return ipSet;
}

const getUniqueUrls = () => {
    const urlSet = new Set();
    jsonData.forEach(record => {
        if (record.httpRequest && record.httpRequest.requestUrl) {
            urlSet.add(record.httpRequest.requestUrl);
        }
    });
    return urlSet;
}

const writeJsonToFile = (data, filename) => {
    try {
        fs.writeFileSync(filename, JSON.stringify(data, null, 2), 'utf8');
        console.log(`Data written to file: ${filename}`);
    } catch (err) {
        console.error(`Error writing to file ${filename}:`, err);
    }
}

const analyzeData = () => {
    const uniqueIps = getUniqueIps();
    const uniqueUrls = getUniqueUrls();
    const output = {
        totalRecords: jsonData.length,
        errorRecords: jsonData.filter(record => record.error).length,
        uniqueIpCount: uniqueIps.size,
        uniqueUrlCount: uniqueUrls.size,
        uniqueRequestIps: Array.from(uniqueIps),
        uniqueTargetUrls: Array.from(uniqueUrls)
    }
    console.dir(output, { depth: null });
    const filename = `./output-json/${inputFile.replace('.json', '_analysis.json').replace(/^.*[\\\/]/, '')}`;
    writeJsonToFile(output, filename);
}

importData();
analyzeData();
