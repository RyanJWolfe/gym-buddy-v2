const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'class',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: 'rgb(var(--color-primary) / <alpha-value>)',
        secondary: 'rgb(var(--color-secondary) / <alpha-value>)',
        muted: 'rgb(var(--color-text-muted) / <alpha-value>)',
        'primary-hover': 'rgb(var(--color-primary-hover) / <alpha-value>)',
        'primary-press': 'rgb(var(--color-primary-press) / <alpha-value>)',
        'secondary-hover': 'rgb(var(--color-secondary-hover) / <alpha-value>)',
        'secondary-press': 'rgb(var(--color-secondary-press) / <alpha-value>)',
        'bg-base': 'rgb(var(--color-bg) / <alpha-value>)',
        'bg-nav': 'rgb(var(--color-bg-nav) / <alpha-value>)',
        surface: 'rgb(var(--color-bg-surface) / <alpha-value>)',
        'surface-alt': 'rgb(var(--color-bg-surface-alt) / <alpha-value>)',
      },
      textColor: {
        based: 'rgb(var(--color-text-based) / <alpha-value>)',
        inverted: 'rgb(var(--color-text-inverted) / <alpha-value>)',
        'based-hover': 'rgb(var(--color-text-based-hover) / <alpha-value>)',
      },
      backgroundColor: {
        base: 'rgb(var(--color-bg) / <alpha-value>)',
        nav: 'rgb(var(--color-bg-nav) / <alpha-value>)',
      },
      gradientColorStops: {
        base: {
          hue: 'rgb(var(--color-bg) / <alpha-value>)',
          surface: 'rgb(var(--color-bg-surface) / <alpha-value>)',
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
