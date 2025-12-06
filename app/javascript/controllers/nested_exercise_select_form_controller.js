import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = ["exerciseFormField", "exerciseContainer"];

  connect() {
    super.connect();
  }

  addExercise(event) {
    event.preventDefault();

    this.newAdd(event);
  }

  // basically what super.add does, but customized to set the exercise id and name on the newly added nested form.
  newAdd(e) {
    e.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML("beforebegin", content)

    const exerciseName = e.target.dataset.exerciseName;
    this.exerciseFormFieldTarget.value = e.target.dataset.exerciseId;
    // remove target attribute so that new adds don't overwrite this one
    this.exerciseFormFieldTarget.removeAttribute("data-nested-exercise-select-form-target");

    this.exerciseContainerTarget.outerHTML = `<div class="exercise-item"><h3>${exerciseName}</h3></div>`

    const event = new CustomEvent("rails-nested-form:add", {bubbles: true})
    this.element.dispatchEvent(event)
  }
}
