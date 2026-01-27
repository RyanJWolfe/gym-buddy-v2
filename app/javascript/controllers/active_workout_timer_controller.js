import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["timer"];
  static values = {
    start: String
  };

  connect() {
    // Parse start time from data attribute (ISO8601 expected)
    this.startTime = null;
    if (this.startValue) {
      const parsed = Date.parse(this.startValue);
      if (!isNaN(parsed)) this.startTime = new Date(parsed);
    }

    // Initialize immediately
    this.update();

    // Only set an interval if we have a valid start time
    if (this.startTime) {
      this.interval = setInterval(() => this.update(), 1000);
    }
  }

  disconnect() {
    if (this.interval) clearInterval(this.interval);
  }

  update() {
    const el = this.timerTarget || this.element;

    // Fallback text when no valid start time
    if (!this.startTime) {
      el.textContent = el.dataset.fallback || "--:--";
      return;
    }

    const now = new Date();
    let diff = Math.max(0, Math.floor((now - this.startTime) / 1000)); // seconds

    const hours = Math.floor(diff / 3600);
    diff = diff % 3600;
    const minutes = Math.floor(diff / 60);
    const seconds = diff % 60;

    const padded = (n) => n.toString().padStart(2, "0");
    const formatted = hours > 0
      ? `${padded(hours)}:${padded(minutes)}:${padded(seconds)}`
      : `${padded(minutes)}:${padded(seconds)}`;

    // Visible text for sighted users
    el.textContent = formatted;

    // Also set an accessible label for screen readers if requested
    if (el.getAttribute("aria-live")) {
      // aria-live will announce changes; keeping textContent is sufficient
    }
  }
}
