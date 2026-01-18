import { Controller } from "@hotwired/stimulus"

// Usage:
// data: {
//     controller: "autosave",
//   }

export default class extends Controller {
  static values = { debounce: Number }

  connect() {
    this.saveTimeout = null
  }

  onInput = () => {
    clearTimeout(this.saveTimeout)
    this.saveTimeout = setTimeout(() => this.save(), this.debounceValue || 500)
  }

  save() {
    this.element.requestSubmit()
  }
}