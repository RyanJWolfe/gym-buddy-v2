import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card-link"
export default class extends Controller {
  static targets = ["link", "button", "sheet"]
  connect() {
  }

  navigate(event) {
    // Prevent navigation if the click originated from a button
    if (event.target.closest('button, a') || this.sheetTarget.contains(event.target)) {
      return;
    }
    const url = this.linkTarget.getAttribute('href');
    if (url) {
      Turbo.visit(url);
    }
  }
}
