import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workouts-toggle"
export default class extends Controller {
  static targets = ["list", "calendar", "container", "slider"]

  connect() {
    // Ensure role for accessibility
    this.element.setAttribute('role', 'tablist')

    // Make the container focusable for keyboard nav
    if (this.hasContainerTarget) {
      this.containerTarget.setAttribute('tabindex', '0')
      this.containerTarget.addEventListener('keydown', this._onKeydown = this.onKeydown.bind(this))
    }

    // Initialize slider and active state from URL
    this.updateStateFromUrl()

    // Reposition on resize and when turbo frames load
    this._onResize = this.positionSlider.bind(this)
    window.addEventListener('resize', this._onResize)

    this._onFrameLoad = this.onFrameLoad.bind(this)
    document.addEventListener('turbo:frame-load', this._onFrameLoad)

    // keep history navigation in sync
    this._onPopstate = this.updateStateFromUrl.bind(this)
    window.addEventListener('popstate', this._onPopstate)
  }

  disconnect() {
    if (this.hasContainerTarget) {
      this.containerTarget.removeEventListener('keydown', this._onKeydown)
    }
    window.removeEventListener('resize', this._onResize)
    document.removeEventListener('turbo:frame-load', this._onFrameLoad)
    window.removeEventListener('popstate', this._onPopstate)
  }

  // Click handler (fires before turbo navigation) — show immediate feedback and fade frame
  switch(event) {
    const anchor = event.currentTarget
    // Determine which target was clicked and set active immediately
    if (this.hasListTarget && this.listTarget && this.listTarget.isSameNode(anchor)) {
      this.setActive('list')
    } else if (this.hasCalendarTarget && this.calendarTarget && this.calendarTarget.isSameNode(anchor)) {
      this.setActive('calendar')
    } else {
      const href = anchor.getAttribute('href') || ''
      if (href.includes('view=calendar')) this.setActive('calendar')
      else this.setActive('list')
    }

    // Micro-interaction: fade the turbo frame while content loads
    const frame = document.getElementById('workouts_view')
    if (frame) {
      frame.classList.add('opacity-40')
    }
  }

  onFrameLoad(event) {
    // When turbo frame finished loading, remove fade and reposition slider
    const frame = document.getElementById('workouts_view')
    if (frame) frame.classList.remove('opacity-40')
    // Reposition slider to match the current active button
    this.positionSlider()
  }

  onKeydown(e) {
    const KEY = e.key
    if (KEY === 'ArrowRight' || KEY === 'ArrowLeft') {
      e.preventDefault()
      // determine current active
      const active = this.currentActive() // 'list' or 'calendar'
      let next = active === 'list' ? 'calendar' : 'list'
      if (KEY === 'ArrowLeft') next = active === 'calendar' ? 'list' : 'calendar'
      this.setActive(next)
      // focus the newly active link
      const el = next === 'list' ? this.listTarget : this.calendarTarget
      if (el && typeof el.focus === 'function') el.focus()
      return
    }

    if (KEY === 'Enter' || KEY === ' ') {
      e.preventDefault()
      // trigger click on active
      const active = this.currentActive()
      const el = active === 'list' ? this.listTarget : this.calendarTarget
      if (el) el.click()
      return
    }
  }

  currentActive() {
    if (this.hasCalendarTarget && this.calendarTarget.getAttribute('aria-pressed') === 'true') return 'calendar'
    return 'list'
  }

  updateStateFromUrl() {
    try {
      const params = new URLSearchParams(window.location.search)
      const view = params.get('view')
      if (view === 'calendar') this.setActive('calendar')
      else this.setActive('list')
    } catch (e) {
      this.setActive('list')
    }
  }

  setActive(which) {
    which = (which === 'calendar') ? 'calendar' : 'list'

    if (this.hasListTarget) this.applyStateToElement(this.listTarget, which === 'list')
    if (this.hasCalendarTarget) this.applyStateToElement(this.calendarTarget, which === 'calendar')

    // ensure slider is positioned after DOM updated
    setTimeout(() => this.positionSlider(), 0)
  }

  applyStateToElement(el, active) {
    if (!el) return
    if (active) {
      el.classList.add('text-primary')
      el.classList.remove('text-gray-600')
      el.setAttribute('aria-pressed', 'true')
      el.setAttribute('aria-selected', 'true')
      el.setAttribute('tabindex', '0')
      el.setAttribute('role', 'tab')
    } else {
      el.classList.remove('text-primary')
      el.classList.add('text-gray-600')
      el.setAttribute('aria-pressed', 'false')
      el.setAttribute('aria-selected', 'false')
      el.setAttribute('tabindex', '-1')
      el.setAttribute('role', 'tab')
    }
  }

  positionSlider() {
    if (!this.hasSliderTarget || !this.hasContainerTarget) return

    // pick the active element
    const active = this.currentActive() === 'calendar' ? this.calendarTarget : this.listTarget
    if (!active) return

    const containerRect = this.containerTarget.getBoundingClientRect()
    const activeRect = active.getBoundingClientRect()

    const left = activeRect.left - containerRect.left
    const width = activeRect.width

    // account for container padding (it has p-1 ~ 0.25rem) - but offsetLeft already within container positioning
    this.sliderTarget.style.width = `${width}px`
    this.sliderTarget.style.transform = `translateX(${left}px)`
  }
}
