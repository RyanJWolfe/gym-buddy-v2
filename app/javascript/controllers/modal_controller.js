import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    // Prevent scrolling on the body when modal is open
    document.body.style.overflow = 'hidden'

    // Add event listener for clicks outside of container
    this.clickListener = this.handleClick.bind(this)
    document.addEventListener('click', this.clickListener)

    // Add event listener for escape key
    this.handleKeydownListener = this.handleKeydown.bind(this)
    document.addEventListener('keydown', this.handleKeydownListener)
  }

  disconnect() {
    // Re-enable scrolling when modal is closed
    document.body.style.overflow = ''

    // Remove event listeners
    document.removeEventListener('keydown', this.handleKeydownListener)
    document.removeEventListener('click', this.clickListener)
  }

  close(event) {
    // Close modal by removing it from the DOM
    this.element.remove()
  }

  handleKeydown(event) {
    // Close modal on escape key
    if (event.key === 'Escape') {
      this.element.remove()
    }
  }

  handleClick(event) {
    // if click is outside of container, close modal
    if (!this.containerTarget.contains(event.target)) {
      this.close()
    }
  }
} 