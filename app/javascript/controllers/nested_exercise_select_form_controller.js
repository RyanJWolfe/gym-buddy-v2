import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = [
    "exerciseContainer",
    "emptyStateContainer",
    "nameField",
    "submitButton"
  ];

  static values = {
    autosave: Boolean,
    autosaveUrl: String,
  }

  connect() {
    super.connect();

    this.toggleSubmitState();

    // If nameField exists, listen for input events to re-evaluate submit state
    if (this.hasNameFieldTarget) {
      this.nameFieldTarget.addEventListener("input", () => this.toggleSubmitState());
    }

    // Listen for nested form add/remove custom events emitted by rails-nested-form
    this.element.addEventListener("rails-nested-form:add", () => this.toggleSubmitState());
    // this.element.addEventListener("rails-nested-form:remove", () => {
    //   this.toggleSubmitState();
    //   this.recalculatePositions();
    // });
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

  autosaveAdd(timestamp, exerciseId) {
    const data = {
      exercise_log: {
        exercise_id: exerciseId,
        position: document.querySelector(`input[name*="${timestamp}"][name$="[position]"]`).value
      }
    };

    fetch(this.autosaveUrlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
      const inputEl = document.querySelector(`input[name*="${timestamp}"]`);
      // duplicate inputEl to create a hidden "id" input
      const hiddenIdInput = document.createElement("input");
      hiddenIdInput.type = "hidden";
      hiddenIdInput.name = inputEl.getAttribute("name").replace(/\[[^\]]*\]$/, "[id]");
      hiddenIdInput.value = data.id;
      inputEl.insertAdjacentElement("afterend", hiddenIdInput);

      const wrapper = inputEl.closest(this.wrapperSelectorValue);
      if (wrapper) {
        wrapper.setAttribute("data-id", data.id);
      }

      const nestedSetForm = wrapper.querySelector(`[data-nested-set-form-autosave-url-value]`)
      nestedSetForm.setAttribute("data-nested-set-form-autosave-url-value", `${this.autosaveUrlValue}/${data.id}/exercise_sets`);


    })
    .catch(error => {
      console.error("Autosave add exercise log error:", error);
    });

  }

  addOne(exerciseId, exerciseName) {
    const timestamp = new Date().getTime().toString();
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, timestamp);
    content = content.replace(/__exercise_dom_id__/g, timestamp);
    this.targetTarget.insertAdjacentHTML("beforebegin", content);

    this.updateForm(exerciseId, exerciseName, timestamp);

    const event = new CustomEvent("rails-nested-form:add", {bubbles: true});
    this.element.dispatchEvent(event);

    if (this.autosaveValue) {
      this.autosaveAdd(timestamp, exerciseId);
    }
  }

  autosaveRemove(formFieldContainer, exerciseLogId) {
    fetch(`${this.autosaveUrlValue}/${exerciseLogId}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    }).then(_ => {
      const inputEl = formFieldContainer.querySelector(`input[name*="[position]"]`);
      const inputName = inputEl.getAttribute("name").replace(/\[[^\]]*\]$/, "");

      formFieldContainer.remove()

      const hiddenIdInput = document.querySelector(`input[name="${inputName}"]`);
      if (hiddenIdInput) hiddenIdInput.remove();

    }).catch(error => {
      console.error("Autosave remove exercise log error:", error);
    });
  }

  remove(e) {
    super.remove(e);

    if (this.formExercisesEmpty()) {
      this.showEmptyState()
    }

    this.toggleSubmitState();
    this.recalculatePositions();

    if (this.autosaveValue) {
      const wrapper = e.target.closest(this.wrapperSelectorValue);
      const idToDelete = wrapper.getAttribute("data-id");
      this.autosaveRemove(wrapper, idToDelete);
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
