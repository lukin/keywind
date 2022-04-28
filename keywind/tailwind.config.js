const colors = require('tailwindcss/colors');

/**
 * @type { import('@types/tailwindcss/tailwind-config').TailwindConfig }
 */
module.exports = {
  content: ['./theme/**/*.ftl'],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      colors: {
        primary: colors.orange,
        secondary: colors.gray,
      },
    },
  },
};
