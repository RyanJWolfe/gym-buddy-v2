import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "equipment"]
  static values = {
    updateUrl: {type: Boolean, default: true}
  }

  connect() {
  }

  // Accept the event so we can read data-search-value from clicked buttons
  onInput(event) {
    // If the event came from an element with a data-search-value, write it into
    // the hidden equipment input (so the form will submit it).
    if (event && event.currentTarget && event.currentTarget.dataset && event.currentTarget.dataset.searchValue) {
      const equipmentValue = event.currentTarget.dataset.searchValue;
      if (this.hasEquipmentTarget) {
        this.equipmentTarget.value = equipmentValue;
      }
    }

    if (this.updateUrlValue && this.hasInputTarget) {
      const query = this.inputTarget.value;
      this.updateSearchParamInUrl(query);
    }

    clearTimeout(this.debounceTimeout);
    this.debounceTimeout = setTimeout(() => {
      this.search();
    }, 300);
  }

  search() {
    if (this.hasFormTarget) {
      this.formTarget.requestSubmit()
    }
  }

  updateSearchParamInUrl(query) {
    const url = new URL(window.location.href);
    url.searchParams.set('search', query);
    window.history.pushState({}, '', url);
  }

  clearResults() {
    // Logic to clear search results, if necessary
    // This could be implemented by resetting the form or clearing a results container
  }
}
