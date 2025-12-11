import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form"]

  connect() {
  }

  onInput() {
    const query = this.inputTarget.value;
    // update ?search query parameter
    const url = new URL(window.location.href);
    url.searchParams.set('search', query);
    window.history.pushState({}, '', url);

    clearTimeout(this.debounceTimeout);
    this.debounceTimeout = setTimeout(() => {
      this.search();
    }, 300);
  }

  search() {
    this.formTarget.requestSubmit()
  }

  clearResults() {
    // Logic to clear search results, if necessary
    // This could be implemented by resetting the form or clearing a results container
  }
}
