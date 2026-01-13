import { Controller } from "@hotwired/stimulus"

// Usage:
// data: {
//     controller: "autosave",
//     "autosave-model-value": "routine",
//     "autosave-url-value": routine_path(@routine),
//     "autosave-debounce-value": 500,
//     "autosave-method-value": "PATCH"
//   }

export default class extends Controller {
  static values = { url: String, debounce: Number, method: String, model: String }

  connect() {
    this.saveTimeout = null
    this.element.addEventListener("input", this.onInput)
    this.element.addEventListener("change", this.onInput)
  }

  disconnect() {
    this.element.removeEventListener("input", this.onInput)
    this.element.removeEventListener("change", this.onInput)
  }

  onInput = (event) => {
    // console.log("AutosaveController detected input/change, scheduling save...")
    // console.log("here is what was changed:", event.target.name, "=", event.target.value)
    clearTimeout(this.saveTimeout)
    this.saveTimeout = setTimeout(() => this.submit(), this.debounceValue || 2000)
  }

  submit() {
    console.log("AutosaveController submitting form...")
    this.element.requestSubmit()
  }

  save() {
    const formData = new FormData(this.element)
    const data = {}

    formData.forEach((value, key) => {
      // Remove model prefix if present (e.g., "routine[name]" => "name")
      const match = key.match(/^[\w-]+\[(.+)\]$/)
      const cleanKey = match ? match[1] : key
      // Exclude Rails hidden fields
      if (cleanKey !== "_method" && cleanKey !== "authenticity_token") {
        data[cleanKey] = value
      }
    })

    const wrappedData = this.modelValue ? { [this.modelValue]: data } : data

    fetch(this.urlValue, {
      method: this.methodValue || "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(wrappedData)
    })
  }
}