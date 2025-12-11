import { Controller } from "@hotwired/stimulus"

// Tracks selected exercise ids, toggles UI, and dispatches an event with selected ids.
export default class extends Controller {
  static targets = ["item", "addButton", "count"]

  connect() {
    this.selected = new Map()
    this.updateAddButton()
  }

  // Toggle selection when an exercise item is clicked
  toggle(event) {
    const el = event.currentTarget
    const id = el.dataset.exerciseId
    const name = el.dataset.exerciseName
    if (!id) return

    if (this.selected.has(id)) {
      this.selected.delete(id)
      el.classList.remove("bg-blue-100", "ring-2")
    } else {
      this.selected.set(id, name)
      el.classList.add("bg-blue-100", "ring-2")
    }

    this.updateAddButton()
  }

  pluralizeExercise(count) {
    return count === 1 ? "exercise" : "exercises"
  }

  // Update add button visibility and count
  updateAddButton() {
    const count = this.selected.size
    if (this.hasAddButtonTarget) {
      if (this.hasCountTarget) this.countTarget.textContent = `${count} ${this.pluralizeExercise(count)}`
      this.addButtonTarget.classList.toggle("hidden", count === 0)
    }
  }

  // Dispatch event with selected ids (bubbles so other controllers can catch it)
  addSelected() {
    const event = new CustomEvent("exercise:add", {
      detail: { exerciseMap: this.selected },
      bubbles: true,
      composed: true
    })
    this.element.dispatchEvent(event)

    // Optionally clear selection after dispatch:
    this.clearSelection()
  }

  clearSelection() {
    this.selected.clear()
    this.itemTargets.forEach(t => t.classList.remove("bg-blue-100", "ring-2"))
    this.updateAddButton()
  }
}
