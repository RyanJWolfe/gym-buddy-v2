import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = ["exerciseFormField", "exerciseContainer", "emptyStateContainer"];

  connect() {
    super.connect();
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
}
