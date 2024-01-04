import type { Config } from 'tailwindcss';
import colors from 'tailwindcss/colors';

export default {
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
