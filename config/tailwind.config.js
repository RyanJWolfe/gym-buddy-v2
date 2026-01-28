const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,html,rb}'
  ],
  darkMode: 'selector',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        display: 'Montserrat',
      },
      fontWeight: {
        extramedium: '550',
      },
      padding: {
        safe: 'env(safe-area-inset-bottom)',
      },
      colors: {
        body: 'rgb(var(--color-body))',
        'bottom-nav': 'rgb(var(--color-bottom-nav))',
        primary: {
          DEFAULT: 'rgb(var(--color-primary))',
          hover: 'rgb(var(--color-primary-hover))',
          focus: 'rgb(var(--color-primary-focus))',
          light: 'rgb(var(--color-primary-light))',
          'light-hover': 'rgb(var(--color-primary-light-hover))',
          ring: 'rgb(var(--color-primary-ring))',
          outline: 'rgb(var(--color-primary-outline))',
        },
        muted: {
          DEFAULT: 'rgb(var(--color-muted))',
          hover: 'rgb(var(--color-muted-hover))',
          focus: 'rgb(var(--color-muted-focus))',
          light: 'rgb(var(--color-muted-light))',
          'light-hover': 'rgb(var(--color-muted-light-hover))',
        },
        surface: {
          DEFAULT: 'rgb(var(--color-surface))',
          secondary: 'rgb(var(--color-surface-secondary))',
          'secondary-hover': 'rgb(var(--color-surface-secondary-hover))',
          border: 'rgb(var(--color-surface-border))',
        },
        accent: {
          DEFAULT: 'rgb(var(--color-accent))',
          hover: 'rgb(var(--color-accent-hover))',
          light: 'rgb(var(--color-accent-light))',
          'light-hover': 'rgb(var(--color-accent-light-hover))',
        },
      }
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
