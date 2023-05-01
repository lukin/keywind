const colors = require('tailwindcss/colors');

/**
 * @type { import('tailwindcss').Config }
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
        primary: colors.blue,
        secondary: colors.gray,
        green: {
          50: "#FOFDF4",
          100: "#DCFCE7",
          200: "#BBF7D0",
          300: "#86EFAC",
          400: "#4ADE80",
        },
        purple: {
          50: "#F6E5FF",
          100: "#E9C2FF",
          200: "#DC9DFF",
          300: "#C150FF",
          400: "#A604FF",
          500: "#7700B8",
          600: "#5D0090",
          700: "#420067",
          800: "#28003D",
          900: "#1A0029",
          main: "#6F42F5",
        },

        teal: {
          50: "#FAF9FB",
          100: "#F5F3F6",
          200: "#E9E5EB",
          300: "#D8D1DB",
          400: "#A89CAF",
          500: "#796B80",
          600: "#5B4B63",
          700: "#483751",
          800: "#2F1F37",
          900: "#14001F",
        },

        provider: {
          bitbucket: '#0052CC',
          facebook: '#1877F2',
          github: '#181717',
          gitlab: '#FC6D26',
          google: '#4285F4',
          instagram: '#E4405F',
          linkedin: '#0A66C2',
          microsoft: '#5E5E5E',
          oidc: '#F78C40',
          openshift: '#EE0000',
          paypal: '#00457C',
          stackoverflow: '#F58025',
          twitter: '#1DA1F2',
        },
      },
    },
  },
};
