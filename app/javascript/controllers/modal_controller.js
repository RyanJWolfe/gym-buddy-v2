import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Prevent scrolling on the body when modal is open
    document.body.style.overflow = 'hidden'

    // Add event listener for escape key
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener('keydown', this.handleKeydown)
  }

  disconnect() {
    // Re-enable scrolling when modal is closed
    document.body.style.overflow = ''

    // Remove event listener for escape key
    document.removeEventListener('keydown', this.handleKeydown)
  }

  close(event) {
    // Close modal by removing it from the DOM
    console.log("closing modal")
    this.element.remove()
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

  handleKeydown(event) {
    // Close modal on escape key
    if (event.key === 'Escape') {
      this.element.remove()
    }
  }
} 