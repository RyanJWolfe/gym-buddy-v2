import {Controller} from "@hotwired/stimulus"

// Tracks selected exercise ids, toggles UI, and dispatches an event with selected ids.
export default class extends Controller {
  static targets = ["item", "addButton", "count"]
  static values = {
    mode: String, // e.g., "add" or "replace" selection mode
    targetDomId: String, // target DOM id for replace mode
    targetId : Number // id of the target element for replace mode
  }

  MODE_ADD = "add";
  MODE_REPLACE = "replace";

  connect() {
    this.selected = new Map()
    this.updateAddButton()
  }

  replaceMode() {
    return this.modeValue === this.MODE_REPLACE
  }

  addMode() {
    return this.modeValue === this.MODE_ADD
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
      if (this.replaceMode()) {
        // Clear previous selection
        this.itemTargets.forEach(t => t.classList.remove("bg-blue-100", "ring-2"))
        this.selected.clear()
      }
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

    if (this.addMode()) {
      this.countTarget.textContent = `${count} ${this.pluralizeExercise(count)}`
    } else if (this.replaceMode()) {
      this.countTarget.textContent = `exercise`
    }

    this.addButtonTarget.classList.toggle("hidden", count === 0)
  }

  // Dispatch event with selected ids (bubbles so other controllers can catch it)
  addSelected() {
    if (this.replaceMode()) {
      this.dispatchReplaceEvent()
    } else if (this.addMode()) {
      this.dispatchAddEvent()
    }

    this.clearSelection()
  }

  dispatchReplaceEvent() {
    const event = new CustomEvent("exercise:replace", {
      detail: {
        mode: "replace",
        targetId: this.targetIdValue,
        targetDomId: this.targetDomIdValue,
        exerciseId: Array.from(this.selected.keys())[0],
        exerciseName: Array.from(this.selected.values())[0]
      },
      bubbles: true,
      composed: true
    })
    this.element.dispatchEvent(event)
  }

  dispatchAddEvent() {
    const event = new CustomEvent("exercise:add", {
      detail: {
        exerciseMap: this.selected,
        exerciseIds: Array.from(this.selected.keys())
      },
      bubbles: true,
      composed: true
    })
    this.element.dispatchEvent(event)
  }

  clearSelection() {
    this.selected.clear()
    this.itemTargets.forEach(t => t.classList.remove("bg-blue-100", "ring-2"))
    this.updateAddButton()
  }
}
