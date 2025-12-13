import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form"]
  static values = {
    updateUrl: {type: Boolean, default: true}
  }

  connect() {
  }

  onInput() {
    if (this.updateUrlValue) {
      const query = this.inputTarget.value;
      this.updateSearchParamInUrl(query);
    }

    clearTimeout(this.debounceTimeout);
    this.debounceTimeout = setTimeout(() => {
      this.search();
    }, 300);
  }

  search() {
    this.formTarget.requestSubmit()
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
