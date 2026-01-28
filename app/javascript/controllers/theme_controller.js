import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"]

  connect() {
    this.textTarget.textContent = this.currentTheme().charAt(0).toUpperCase() + this.currentTheme().slice(1)
  }

  currentTheme() {
    return localStorage.theme || 'system'
  }

  selectLight() {
    localStorage.theme = 'light'
    this.toggleTheme()
    this.textTarget.textContent = 'Light'
  }

  selectDark() {
    localStorage.theme = 'dark'
    this.toggleTheme()
    this.textTarget.textContent = 'Dark'
  }

  selectSystem() {
    localStorage.removeItem('theme')
    this.toggleTheme()
    this.textTarget.textContent = 'System'
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
