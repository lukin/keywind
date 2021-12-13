/**
 * @type { import("snowpack").SnowpackUserConfig }
 */
module.exports = {
  buildOptions: {
    out: './theme/keywind/login/resources',
  },
  devOptions: {
    tailwindConfig: './tailwind.config.js',
  },
  mount: {
    src: '/dist',
  },
  optimize: {
    bundle: true,
    entrypoints: ['./src/index.js'],
    minify: true,
    target: 'es6',
  },
  plugins: ['@snowpack/plugin-postcss'],
};
