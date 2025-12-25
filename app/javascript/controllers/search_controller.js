import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "filter", "clearFiltersButton"]
  static values = {
    updateUrl: {type: Boolean, default: true}
  }

  connect() {
  }

  validEventTarget(eventTarget) {
    if (eventTarget === this.inputTarget)
      return true;

    return eventTarget.dataset && eventTarget.dataset.searchValue !== undefined
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

      // if there are any active filters, display the clear filters button
      if (this.hasClearFiltersButtonTarget) {
        const anyActiveFilters = this.filterTargets.some(t => t.classList.contains("bg-blue-100"));

        const hiddenClasses = ["opacity-0", "pointer-events-none", "scale-50"]
        const visibleClasses = ["opacity-100", "pointer-events-auto", "scale-100"]

        if (anyActiveFilters) {
          this.clearFiltersButtonTarget.classList.add(...visibleClasses);
          this.clearFiltersButtonTarget.classList.remove(...hiddenClasses);
          this.clearFiltersButtonTarget.setAttribute('aria-hidden', 'false');
        } else {
          this.clearFiltersButtonTarget.classList.remove(...visibleClasses);
          this.clearFiltersButtonTarget.classList.add(...hiddenClasses);
          this.clearFiltersButtonTarget.setAttribute('aria-hidden', 'true');
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
    if (this.hasFilterTarget && this.filterTargets.includes(eventTarget)) {
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

  clearFilters() {
    this.filterTargets.forEach(t => {
      t.classList.remove("bg-blue-100", "ring-2");
      const fieldName = t.dataset.searchLabel;
      const selector = `[data-search-filter-label="${fieldName}"]`
      const labelElement = document.querySelector(selector);
      if (labelElement && labelElement.classList && labelElement.classList.contains("btn-primary")) {
        labelElement.textContent = labelElement.dataset.searchFilterDefaultText;
        labelElement.classList.remove("btn-primary")
        labelElement.classList.add("btn-tertiary")
      }
      this.updateFormField("", fieldName);
    });

    this.search()
  }

  clearResults() {
    // Logic to clear search results, if necessary
    // This could be implemented by resetting the form or clearing a results container
  }
}
