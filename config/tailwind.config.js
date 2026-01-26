const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,html,rb}'
  ],
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
        body: "#f5f5f5",
        primary: {
          DEFAULT: "#4f46e5",
          hover: "#4338ca",
          focus: "#6366f1",
          light: "#eef2ff",
          'light-hover': "#e0e7ff",
          ring: "#6366f1",
          outline: "#c7d2fe",
        },
        muted: {
          DEFAULT: "#525252",
          hover: "#9ca3af",
          light: "#737373",
        }
      }
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
