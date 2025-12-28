import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = [
    "exerciseContainer",
    "emptyStateContainer",
    "nameField",
    "submitButton"
  ];

  connect() {
    super.connect();

    this.toggleSubmitState();

    // If nameField exists, listen for input events to re-evaluate submit state
    if (this.hasNameFieldTarget) {
      this.nameFieldTarget.addEventListener("input", () => this.toggleSubmitState());
    }

    // Listen for nested form add/remove custom events emitted by rails-nested-form
    this.element.addEventListener("rails-nested-form:add", () => this.toggleSubmitState());
    this.element.addEventListener("rails-nested-form:remove", () => {
      this.toggleSubmitState();
      this.recalculatePositions();
    });
  }

  replaceExercise(event) {
    event.preventDefault();

    const {exerciseId, exerciseName, targetDomId} = event.detail;
    const targetElement = document.getElementById(targetDomId);
    const exerciseFormField = targetElement.querySelector(
        `input[name$="[exercise_id]"]`);
    const exerciseContainer = targetElement.querySelector("h5");

    exerciseFormField.value = exerciseId;
    exerciseContainer.outerHTML = `<h5 class="font-medium">${exerciseName}</h5>`;

  }

  // handler for the bubbled `exercise:add` CustomEvent with multiple ids
  addExercises(event) {
    event.preventDefault();

    const selectedExercisesMap = event?.detail?.exerciseMap;
    if (!selectedExercisesMap || !(selectedExercisesMap instanceof Map) || selectedExercisesMap.size === 0) {
      return;
    }

    this.removeEmptyState();

    for (const [id, name] of selectedExercisesMap) {
      this.addOne(id, name || "");
    }

    // re-evaluate submit state after adding all
    this.toggleSubmitState();
  }

  addOne(exerciseId, exerciseName) {
    const timestamp = new Date().getTime().toString();
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, timestamp);
    content = content.replace(/__exercise_dom_id__/g, timestamp);
    this.targetTarget.insertAdjacentHTML("beforebegin", content);

    this.updateForm(exerciseId, exerciseName, timestamp);

    const event = new CustomEvent("rails-nested-form:add", {bubbles: true});
    this.element.dispatchEvent(event);
  }

  remove(e) {
    super.remove(e);

    if (this.formExercisesEmpty()) {
      this.showEmptyState()
    }
  }

  recalculatePositions() {
    const exerciseForms = document.querySelectorAll(this.wrapperSelectorValue);
    exerciseForms.forEach((form, index) => {
      const positionInput = form.querySelector('input[name*="[position]"]');
      if (positionInput) {
        positionInput.value = index + 1;
      }
    });
  }

  formExercisesEmpty() {
    return this.exerciseCount() === 0;
  }

  updateForm(exerciseId, exerciseName, timestamp) {
    const exerciseIdFormField = document.querySelector(`input[name*="${timestamp}"][name$="[exercise_id]"]`);
    const positionFormField = document.querySelector(`input[name*="${timestamp}"][name$="[position]"]`);
    const exerciseNameContainer = document.getElementById(`${timestamp}-exercise-name`);

    exerciseIdFormField.value = exerciseId;
    positionFormField.value = this.exerciseCount();
    exerciseNameContainer.outerHTML = `<h5 class="font-medium">${exerciseName}</h5>`;
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
    const exerciseContainers = document.querySelectorAll(this.wrapperSelectorValue);
    let nonHiddenCount = 0;

    exerciseContainers.forEach((container) => {
      if (!container.style.display || container.style.display !== 'none') {
        nonHiddenCount += 1;
      }
    });

    return nonHiddenCount
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
