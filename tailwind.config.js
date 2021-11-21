const colors = require('tailwindcss/colors');

/**
 * @type { import('@types/tailwindcss/tailwind-config').TailwindConfig }
 */
module.exports = {
  darkMode: 'media',
  plugins: [require('@tailwindcss/forms')],
  purge: ['./theme/**/*.ftl'],
  theme: {
    extend: {
      colors: {
        primary: colors.blue,
      },
    },
  },
};
