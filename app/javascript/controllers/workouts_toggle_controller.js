import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workouts-toggle"
export default class extends Controller {
  static targets = ["list", "calendar"]

  connect() {
    // Define classes used for active/inactive states
    this.activeClasses = ["bg-white", "shadow", "text-gray-900"]
    this.inactiveClasses = ["text-gray-600"]

    // Ensure role for accessibility
    this.element.setAttribute('role', 'tablist')

    // Initialize state based on current URL
    this.updateStateFromUrl()

    // Keep state in sync when the user navigates browser history or turbo frames load
    this._onPopstate = this.updateStateFromUrl.bind(this)
    window.addEventListener('popstate', this._onPopstate)
    document.addEventListener('turbo:frame-load', this._onPopstate)
  }

  disconnect() {
    window.removeEventListener('popstate', this._onPopstate)
    document.removeEventListener('turbo:frame-load', this._onPopstate)
  }

  // Click handler (fires before turbo navigation) — show immediate feedback
  switch(event) {
    const anchor = event.currentTarget
    // Determine which target was clicked
    if (this.hasListTarget && this.listTarget && this.listTarget.isSameNode(anchor)) {
      this.setActive('list')
    } else if (this.hasCalendarTarget && this.calendarTarget && this.calendarTarget.isSameNode(anchor)) {
      this.setActive('calendar')
    } else {
      // fallback: inspect href
      const href = anchor.getAttribute('href') || ''
      if (href.includes('view=calendar')) this.setActive('calendar')
      else this.setActive('list')
    }
  }

  updateStateFromUrl() {
    try {
      const params = new URLSearchParams(window.location.search)
      const view = params.get('view')
      if (view === 'calendar') this.setActive('calendar')
      else this.setActive('list')
    } catch (e) {
      // default to list on any parse error
      this.setActive('list')
    }
  }

  setActive(which) {
    // Normalize
    which = (which === 'calendar') ? 'calendar' : 'list'

    // Apply classes and aria attributes
    if (this.hasListTarget) this.applyStateToElement(this.listTarget, which === 'list')
    if (this.hasCalendarTarget) this.applyStateToElement(this.calendarTarget, which === 'calendar')
  }

  applyStateToElement(el, active) {
    if (active) {
      el.classList.remove(...this.inactiveClasses)
      el.classList.add(...this.activeClasses)
      el.setAttribute('aria-pressed', 'true')
      el.setAttribute('aria-selected', 'true')
      el.setAttribute('tabindex', '0')
      el.setAttribute('role', 'tab')
    } else {
      el.classList.remove(...this.activeClasses)
      el.classList.add(...this.inactiveClasses)
      el.setAttribute('aria-pressed', 'false')
      el.setAttribute('aria-selected', 'false')
      el.setAttribute('tabindex', '-1')
      el.setAttribute('role', 'tab')
    }
  }
}
