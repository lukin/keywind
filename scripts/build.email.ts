import { exec } from 'child-process-promise';
import * as path from 'node:path';
import { readdirSync, readFileSync, writeFileSync } from 'node:fs';

//BUILD:Head-Files
const directoryPath = path.join(__dirname, '../theme/keywind/email/html-src');
const directoryPathComponents = path.join(
  __dirname,
  '../theme/keywind/email/html-src/components/atoms'
);
const files = [
  ...readdirSync(directoryPath),
  ...readdirSync(directoryPathComponents).map((e) => `components/atoms/${e}`),
];

for (let file of files) {
  if (file.includes('.ftl')) {
    // Build using mailwind
    await exec(
      `mailwind --input-html ${path.join(
        __dirname,
        `../theme/keywind/email/html-src/${file}`
      )} --output-html ${path.join(__dirname, `../theme/keywind/email/html/${file}`)}`
    );
    // fix: wrong build result for ftl-file exception
    const data = readFileSync(path.join(__dirname, `../theme/keywind/email/html/${file}`));
    const result = data
      .toString()
      .replaceAll('<!--@', '</@')
      .replaceAll('<!--#', '</#')
      .replaceAll('-->', '>');
    writeFileSync(path.join(__dirname, `../theme/keywind/email/html/${file}`), result);
  }
}
