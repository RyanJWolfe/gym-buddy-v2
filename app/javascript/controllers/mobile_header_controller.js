import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-header"
export default class extends Controller {
  static values = { shadowClass: { type: String, default: 'shadow-top' } }

  connect() {
    // The element is the <nav>
    this.onScroll = this.onScroll.bind(this)
    // Use passive listener for performance
    window.addEventListener('scroll', this.onScroll, { passive: true })
    // Run once to set initial state
    this.onScroll()
  }

  disconnect() {
    window.removeEventListener('scroll', this.onScroll)
  }

  onScroll() {
    const scrolled = window.scrollY > 50
    if (scrolled) {
      this.element.classList.add(this.shadowClassValue)
    } else {
      this.element.classList.remove(this.shadowClassValue)
    }
  }
}
