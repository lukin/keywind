import type { Config } from 'tailwindcss';

export default {
  content: ['./theme/**/*.ftl'],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      fontFamily: {
        sans: '"Noto Sans", ui-sans-serif, system-ui, sans-serif',
        serif: '"Noto Serif", ui-serif, Georgia, Cambria, "Times New Roman", serif',
      },
      colors: {
        primary: {
          50: 'rgb(var(--color-sta-primary-50) / <alpha-value>)',
          100: 'rgb(var(--color-sta-primary-100) / <alpha-value>)',
          200: 'rgb(var(--color-sta-primary-200) / <alpha-value>)',
          300: 'rgb(var(--color-sta-primary-300) / <alpha-value>)',
          400: 'rgb(var(--color-sta-primary-400) / <alpha-value>)',
          500: 'rgb(var(--color-sta-primary-500) / <alpha-value>)',
          600: 'rgb(var(--color-sta-primary-600) / <alpha-value>)',
          700: 'rgb(var(--color-sta-primary-700) / <alpha-value>)',
          800: 'rgb(var(--color-sta-primary-800) / <alpha-value>)',
          900: 'rgb(var(--color-sta-primary-900) / <alpha-value>)',
          950: 'rgb(var(--color-sta-primary-950) / <alpha-value>)'
        },
        secondary: {
          50: 'rgb(var(--color-sta-secondary-50) / <alpha-value>)',
          100: 'rgb(var(--color-sta-secondary-100) / <alpha-value>)',
          200: 'rgb(var(--color-sta-secondary-200) / <alpha-value>)',
          300: 'rgb(var(--color-sta-secondary-300) / <alpha-value>)',
          400: 'rgb(var(--color-sta-secondary-400) / <alpha-value>)',
          500: 'rgb(var(--color-sta-secondary-500) / <alpha-value>)',
          600: 'rgb(var(--color-sta-secondary-600) / <alpha-value>)',
          700: 'rgb(var(--color-sta-secondary-700) / <alpha-value>)',
          800: 'rgb(var(--color-sta-secondary-800) / <alpha-value>)',
          900: 'rgb(var(--color-sta-secondary-900) / <alpha-value>)',
          950: 'rgb(var(--color-sta-secondary-950) / <alpha-value>)'
        },

        provider: {
          apple: 'rgb(var(--color-provider-apple) / <alpha-value>)',
          bitbucket: 'rgb(var(--color-provider-bitbucket) / <alpha-value>)',
          discord: 'rgb(var(--color-provider-discord) / <alpha-value>)',
          facebook: 'rgb(var(--color-provider-facebook) / <alpha-value>)',
          github: 'rgb(var(--color-provider-github) / <alpha-value>)',
          gitlab: 'rgb(var(--color-provider-gitlab) / <alpha-value>)',
          google: 'rgb(var(--color-provider-google) / <alpha-value>)',
          instagram: 'rgb(var(--color-provider-instagram) / <alpha-value>)',
          linkedin: 'rgb(var(--color-provider-linkedin) / <alpha-value>)',
          microsoft: 'rgb(var(--color-provider-microsoft) / <alpha-value>)',
          oidc: 'rgb(var(--color-provider-oidc) / <alpha-value>)',
          openshift: 'rgb(var(--color-provider-openshift) / <alpha-value>)',
          paypal: 'rgb(var(--color-provider-paypal) / <alpha-value>)',
          slack: 'rgb(var(--color-provider-slack) / <alpha-value>)',
          stackoverflow: 'rgb(var(--color-provider-stackoverflow) / <alpha-value>)',
          twitter: 'rgb(var(--color-provider-twitter) / <alpha-value>)',
        },
      },
    },
  },
} satisfies Config;
