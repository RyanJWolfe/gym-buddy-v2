import { Controller } from "@hotwired/stimulus"

// Generic segmented toggle controller
export default class extends Controller {
  static targets = ["list", "calendar", "container", "slider"]

  connect() {
    this.element.setAttribute('role', 'tablist')

    // container target
    if (this.hasContainerTarget) {
      this.containerTarget.setAttribute('tabindex', '0')
      this.containerTarget.addEventListener('keydown', this._onKeydown = this.onKeydown.bind(this))
    }

    // read frame from data attribute (eg data-segmented-toggle-frame)
    this.frameId = this.hasContainerTarget ? this.containerTarget.getAttribute('data-segmented-toggle-frame') : null

    // Initialize slider and active state from URL
    this.updateStateFromUrl()

    // listeners
    this._onResize = this.positionSlider.bind(this)
    window.addEventListener('resize', this._onResize)

    this._onFrameLoad = this.onFrameLoad.bind(this)
    document.addEventListener('turbo:frame-load', this._onFrameLoad)

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

  switch(event) {
    const anchor = event.currentTarget
    if (this.hasListTarget && this.listTarget && this.listTarget.isSameNode(anchor)) {
      this.setActive('list')
    } else if (this.hasCalendarTarget && this.calendarTarget && this.calendarTarget.isSameNode(anchor)) {
      this.setActive('calendar')
    } else {
      const href = anchor.getAttribute('href') || ''
      if (href.includes('view=calendar')) this.setActive('calendar')
      else this.setActive('list')
    }

    // fade frame
    const frame = document.getElementById(this.frameId)
    if (frame) frame.classList.add('opacity-40')
  }

  onFrameLoad() {
    const frame = document.getElementById(this.frameId)
    if (frame) frame.classList.remove('opacity-40')
    this.positionSlider()
  }

  onKeydown(e) {
    const KEY = e.key
    if (KEY === 'ArrowRight' || KEY === 'ArrowLeft') {
      e.preventDefault()
      const active = this.currentActive()
      let next = active === 'list' ? 'calendar' : 'list'
      if (KEY === 'ArrowLeft') next = active === 'calendar' ? 'list' : 'calendar'
      this.setActive(next)
      const el = next === 'list' ? this.listTarget : this.calendarTarget
      if (el && typeof el.focus === 'function') el.focus()
      return
    }

    if (KEY === 'Enter' || KEY === ' ') {
      e.preventDefault()
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
    setTimeout(() => this.positionSlider(), 0)
  }

  applyStateToElement(el, active) {
    if (!el) return
    if (active) {
      el.classList.add('text-white')
      el.classList.remove('text-gray-600', 'dark:text-neutral-400')
      el.setAttribute('aria-pressed', 'true')
      el.setAttribute('aria-selected', 'true')
      el.setAttribute('tabindex', '0')
      el.setAttribute('role', 'tab')
    } else {
      el.classList.remove('text-white')
      el.classList.add('text-gray-600', 'dark:text-neutral-400')
      el.setAttribute('aria-pressed', 'false')
      el.setAttribute('aria-selected', 'false')
      el.setAttribute('tabindex', '-1')
      el.setAttribute('role', 'tab')
    }
  }

  positionSlider() {
    if (!this.hasSliderTarget || !this.hasContainerTarget) return
    const active = this.currentActive() === 'calendar' ? this.calendarTarget : this.listTarget
    if (!active) return
    const containerRect = this.containerTarget.getBoundingClientRect()
    const activeRect = active.getBoundingClientRect()
    const left = activeRect.left - containerRect.left
    const width = activeRect.width
    this.sliderTarget.style.width = `${width}px`
    const overshootScale = 1.03
    const normalScale = 1
    const translate = `translate3d(${left}px, 0, 0)`
    this.sliderTarget.style.transform = `${translate} scale(${overshootScale})`
    this.sliderTarget.classList.add('shadow-md')
    clearTimeout(this._popTimeout)
    this._popTimeout = setTimeout(() => {
      this.sliderTarget.style.transform = `${translate} scale(${normalScale})`
      setTimeout(() => { this.sliderTarget.classList.remove('shadow-md') }, 220)
    }, 120)
  }
}
