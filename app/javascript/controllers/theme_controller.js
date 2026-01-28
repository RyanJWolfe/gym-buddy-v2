import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text", "option"]

  connect() {
    this.textTarget.textContent = this.currentTheme().charAt(0).toUpperCase() + this.currentTheme().slice(1)
    this.updateSelection()
  }

  currentTheme() {
    return localStorage.theme || 'system'
  }

  selectLight() {
    localStorage.theme = 'light'
    this.toggleTheme()
    this.textTarget.textContent = 'Light'
    this.updateSelection()
  }

  selectDark() {
    localStorage.theme = 'dark'
    this.toggleTheme()
    this.textTarget.textContent = 'Dark'
    this.updateSelection()
  }

  selectSystem() {
    localStorage.removeItem('theme')
    this.toggleTheme()
    this.textTarget.textContent = 'System'
    this.updateSelection()
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

    // force a reflow so transitions are suppressed briefly
    window.getComputedStyle(css).opacity;
    document.head.removeChild(css)
  }

  updateSelection() {
    if (!this.hasOptionTarget) return

    const current = this.currentTheme()

    this.optionTargets.forEach((el) => {
      const val = el.dataset.value || el.getAttribute('data-value')
      const isSelected = val === current

      el.setAttribute('aria-pressed', isSelected ? 'true' : 'false')

      // show or hide the checkmark SVG inside the option
      const checkWrapper = el.querySelector('[data-check]')
      if (checkWrapper) {
        const icon = checkWrapper.firstElementChild
        if (icon && icon.classList) {
          // hide when not selected, show when selected
          icon.classList.toggle('hidden', !isSelected)
        }
      }
    })
  }
}
