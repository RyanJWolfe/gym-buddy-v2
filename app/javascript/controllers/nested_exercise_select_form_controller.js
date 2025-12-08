import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = ["exerciseFormField", "exerciseContainer", "emptyStateContainer", "nameField", "submitButton"];

  connect() {
    super.connect();

    this.toggleSubmitState();

    // If nameField exists, listen for input events to re-evaluate submit state
    if (this.hasNameFieldTarget) {
      this.nameFieldTarget.addEventListener("input", () => this.toggleSubmitState());
    }

    // Listen for nested form add/remove custom events emitted by rails-nested-form
    this.element.addEventListener("rails-nested-form:add", () => this.toggleSubmitState());
    this.element.addEventListener("rails-nested-form:remove", () => this.toggleSubmitState());
  }

  addExercise(event) {
    event.preventDefault();

    this.newAdd(event);
  }

  remove(e) {
    super.remove(e);

    if (this.formExercisesEmpty()) {
      this.showEmptyState()
    }
  }

  formExercisesEmpty() {
    return document.querySelector(this.wrapperSelectorValue) === null
  }

  // basically what super.add does, but customized to set the exercise id and name on the newly added nested form.
  newAdd(e) {
    e.preventDefault()

    this.removeEmptyState();

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML("beforebegin", content)

    this.setExerciseField(e.target.dataset.exerciseId, e.target.dataset.exerciseName);

    const event = new CustomEvent("rails-nested-form:add", {bubbles: true})
    this.element.dispatchEvent(event)
  }

  setExerciseField(exerciseId, exerciseName) {
    this.exerciseFormFieldTarget.value = exerciseId;
    this.exerciseContainerTarget.outerHTML = `<h5 class="font-medium">${exerciseName}</h5>`;
    // remove target attribute so that new adds don't overwrite this one
    this.exerciseFormFieldTarget.removeAttribute("data-nested-exercise-select-form-target");
  }

  removeEmptyState() {
    if (this.hasEmptyStateContainerTarget && !this.emptyStateContainerTarget.classList.contains("hidden")) {
      this.emptyStateContainerTarget.classList.add("hidden");
    }
  }

  showEmptyState() {
    this.emptyStateContainerTarget.classList.remove("hidden");
  }

  exerciseCount() {
    // forms have a wrapper selector value provided via data attribute on the form (wrapperSelectorValue comes from rails-nested-form)
    try {
      const selector = this.wrapperSelectorValue;
      if (!selector) return 0;
      return document.querySelectorAll(selector).length;
    } catch (err) {
      return 0;
    }
  }

  hasName() {
    return this.hasNameFieldTarget && this.nameFieldTarget.value.trim().length > 0;
  }

  toggleSubmitState() {
    if (!this.hasSubmitButtonTarget) return;

    const shouldEnable = this.hasName() && this.exerciseCount() > 0;

    this.submitButtonTarget.disabled = !shouldEnable;

    // add/remove opacity/disabled styles to match project's button disabled visuals
    if (shouldEnable) {
      this.submitButtonTarget.classList.remove("opacity-50", "pointer-events-none", "cursor-not-allowed");
    } else {
      this.submitButtonTarget.classList.add("opacity-50", "pointer-events-none", "cursor-not-allowed");
    }
  }
}
