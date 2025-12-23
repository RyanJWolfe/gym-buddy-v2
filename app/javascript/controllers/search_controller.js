import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "filter"]
  static values = {
    updateUrl: {type: Boolean, default: true}
  }

  connect() {
  }

  validEventTarget(eventTarget) {
    return eventTarget && eventTarget.dataset && eventTarget.dataset.searchValue !== undefined;
  }

  updateFormField(value, fieldName) {
    const formField = this.element.querySelector(`input[name="${fieldName}"]`);
    if (!formField) return;

    formField.value = value;
  }

  handleFilters(eventTarget, fieldName, searchValue) {
    try {
      this.filterTargets
          .filter(t => t.dataset.searchLabel === fieldName)
          .forEach(t => t.classList.remove("bg-blue-100", "ring-2"));

      eventTarget.classList.add("bg-blue-100", "ring-2");
      if (fieldName === undefined) return;

      const selector = `[data-search-filter-label="${fieldName}"]`
      const labelElement = document.querySelector(selector);
      if (labelElement && labelElement.classList) {
        labelElement.textContent = eventTarget.dataset.searchName
        if (searchValue === "") {
          labelElement.classList.remove("btn-primary")
          labelElement.classList.add("btn-tertiary")
        } else {
          labelElement.classList.add("btn-primary")
          labelElement.classList.remove("btn-tertiary")
        }
      }
    } catch (e) {
      // ignore if DOM manipulation fails
      console.warn('Failed to toggle filter active classes', e);
    }
  }

  onInput(event) {
    const eventTarget = event.currentTarget;

    if (!this.validEventTarget(eventTarget)) return

    const searchValue = eventTarget.dataset.searchValue;
    const fieldName = eventTarget.dataset.searchLabel
    this.updateFormField(searchValue, fieldName);

    // Toggle active class on filter buttons for instant feedback
    if (this.hasFilterTarget) {
      this.handleFilters(eventTarget, fieldName, searchValue);
    }

    if (this.updateUrlValue && this.hasInputTarget) {
      const query = this.inputTarget.value;
      this.updateSearchParamInUrl(query);
    }

    clearTimeout(this.debounceTimeout);

    if (event.type === 'click') {
      this.search();
      return;
    }
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
