import { Controller } from "@hotwired/stimulus"

// Usage: data-controller="clearable-input" on wrapper
// data-clearable-input-target="input" on input
// data-clearable-input-target="clearButton" on clear button

export default class extends Controller {
  static targets = ["input", "clearButton"]

  connect() {
    // Set initial button state after any autofill or programmatic changes
    setTimeout(() => this.toggleButton(), 0)
  }

  changed() {
    this.toggleButton()
  }

  toggleButton() {
    const hasValue = this.inputTarget && this.inputTarget.value && this.inputTarget.value.trim().length > 0
    if (!this.hasClearButtonTarget) return

    const hiddenClasses = ["opacity-0", "pointer-events-none", "scale-50"]
    const visibleClasses = ["opacity-100", "pointer-events-auto", "scale-100"]

    if (hasValue) {
      this.show(hiddenClasses, visibleClasses)
    } else {
      this.hide(hiddenClasses, visibleClasses)
    }
  }

  show(hiddenClasses, visibleClasses) {
    hiddenClasses.forEach(c => this.clearButtonTarget.classList.remove(c))
    visibleClasses.forEach(c => this.clearButtonTarget.classList.add(c))
    this.clearButtonTarget.setAttribute('aria-hidden', 'false')
  }

  hide(hiddenClasses, visibleClasses) {
    visibleClasses.forEach(c => this.clearButtonTarget.classList.remove(c))
    hiddenClasses.forEach(c => this.clearButtonTarget.classList.add(c))
    this.clearButtonTarget.setAttribute('aria-hidden', 'true')
  }

  clear(event) {
    event.preventDefault()
    if (!this.inputTarget) return

    this.inputTarget.value = ""

    // Dispatch input event so any listeners update
    const evt = new Event('input', {bubbles: true})
    this.inputTarget.dispatchEvent(evt)
    this.toggleButton()
    // focus the input after clearing
    this.inputTarget.focus()
  }
}
