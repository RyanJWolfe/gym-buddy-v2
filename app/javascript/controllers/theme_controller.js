import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  selectLight() {
    localStorage.theme = 'light'
    this.toggleTheme()
  }

  selectDark() {
    localStorage.theme = 'dark'
    this.toggleTheme()
  }

  selectSystem() {
    localStorage.removeItem('theme')
    this.toggleTheme()
  }

  toggleTheme() {
    const css = document.createElement('style')
    css.type = 'text/css'
    css.appendChild(
        document.createTextNode(
            `* {
       -webkit-transition: none !important;
       -moz-transition: none !important;
       -o-transition: none !important;
       -ms-transition: none !important;
       transition: none !important;
    }`
        )
    )
    document.head.appendChild(css)

    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const isDark = localStorage.theme === 'dark' || (!('theme' in localStorage) && prefersDark);

    ['dark', 'theme-dark'].forEach(cls =>
        document.documentElement.classList.toggle(cls, isDark)
    );

    const _ = window.getComputedStyle(css).opacity
    document.head.removeChild(css)
  }
}
