// @ts-check

const { concatFilesForPrettier } = require('@wayofdev/lint-staged-config');

const json = require('@wayofdev/lint-staged-config/json');
const yaml = require('@wayofdev/lint-staged-config/yaml');
const secrets = require('@wayofdev/lint-staged-config/secrets');
const md = require('@wayofdev/lint-staged-config/md');

const rules = {
  ...json,
  ...yaml,
  ...secrets,
  '**/*.{js,jsx,cjs,mjs,ts,tsx,mts,cts}': (filenames) => {
    return [`prettier --write ${concatFilesForPrettier(filenames)}`];
  },
};

module.exports = rules;
