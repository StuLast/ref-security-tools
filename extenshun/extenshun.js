import sources from './assets/sources.json' with { type: 'json' };
import definitions from './assets/definitions.json' with { type: 'json' };
import fs from 'fs';
import os from 'os';
import path from 'path';
const userHome = os.homedir();

const getVsCodePath = (sourceFilePath) => {
    return path.join(userHome, sourceFilePath);
} 

const checkDefinitions = (response, definitions) => {
    for(const definition of definitions) {
        const found = response.some(ext => ext.identifier.id === definition.name && ext.version === definition.version);
        if (found) {
            console.log(` - Definition ${definition.name} version ${definition.version} found in VSCode.`);
        }
    }
}

const checkSources = async (sources) => {
    for (const source of sources.sourceList) {
        if (source.vscode) {
            const response = await getExtensions(source.vscode.extensionPath);
            checkDefinitions(response, definitions.vscode.definitions);
        }
    }
    const extensions = [];
    return extensions;
}

const getExtensions = async (sourceFilePath) => {
    try {
        const data = await fs.promises.readFile(getVsCodePath(sourceFilePath));
        return JSON.parse(data.toString());
    } catch (err) {
        console.error(`Error reading file ${sourceFilePath}:`, err);
        return null;
    }
}

await checkSources(sources);