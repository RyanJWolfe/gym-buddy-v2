import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "filter"]
  static values = {
    updateUrl: {type: Boolean, default: true}
  }

  connect() {
  }

  // Accept the event so we can read data-search-value from clicked buttons
  onInput(event) {
    // If the event came from an element with a data-search-value, write it into
    // the hidden equipment input (so the form will submit it) and update UI.
    if (event && event.currentTarget && event.currentTarget.dataset && event.currentTarget.dataset.searchValue !== undefined) {
      const value = event.currentTarget.dataset.searchValue;
      const fieldName = event.currentTarget.dataset.searchLabel
      const formField = this.element.querySelector(`input[name="${fieldName}"]`);
      if (formField) {
        formField.value = value;
      }

      // Toggle active class on filter buttons for instant feedback
      if (this.hasFilterTarget) {
        try {
          this.filterTargets.forEach(t => t.classList.remove("bg-blue-100", "ring-2"));
          // event.currentTarget should be one of the filter targets; guard defensively
          if (event.currentTarget.classList) {
            event.currentTarget.classList.add("bg-blue-100", "ring-2");

            if (fieldName !== undefined) {
              const selector = `[data-search-filter-label="${fieldName}"]`
              const labelElement = document.querySelector(selector);
              if (labelElement && labelElement.classList) {
                labelElement.textContent = event.currentTarget.dataset.searchName
                if (event.currentTarget.dataset.searchValue === "") {
                  labelElement.classList.remove("btn-primary")
                  labelElement.classList.add("btn-tertiary")
                } else {
                  labelElement.classList.add("btn-primary")
                  labelElement.classList.remove("btn-tertiary")
                }
              }
            }
          }
        } catch (e) {
          // ignore if DOM manipulation fails
          console.warn('Failed to toggle filter active classes', e);
        }
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
