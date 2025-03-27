import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Prevent scrolling on the body when modal is open
    document.body.style.overflow = 'hidden'
  }

  disconnect() {
    // Re-enable scrolling when modal is closed
    document.body.style.overflow = ''
  }

  close(event) {
    // Close modal by removing it from the DOM
    this.element.remove()
  }
} 