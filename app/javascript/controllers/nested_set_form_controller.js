import RailsNestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="nested-exercise-select-form"
export default class extends RailsNestedForm {
  static targets = ["setFormField"];

  connect() {
    super.connect();
  }

  add(e) {
    e.preventDefault();

    this.addSet(e);
  }

  remove(e) {
    super.remove(e);

    this.reorderSetNumbers();
  }

  // Custom method to set the order field (set_number) when a new set is added
  addSet(e) {
    e.preventDefault()

    const timestamp = new Date().getTime().toString()

    const content = this.templateTarget.innerHTML.replace(/NEW_SET_RECORD/g, timestamp)
    this.targetTarget.insertAdjacentHTML("beforebegin", content)

    this.setOrderField(timestamp);
    this.setInitialInputs(timestamp);

    const event = new CustomEvent("rails-nested-form:add", {bubbles: true})
    this.element.dispatchEvent(event)
  }

  reorderSetNumbers() {
    let index = 1
    this.setFormFieldTargets.forEach((field) => {
      if (field.style.display === "none") return

      const input = field.querySelector('input[name$="[set_number]"]');
      if (input) {
        input.value = index;
        index += 1;
      }
    });
  }

  setOrderField(newSetTimestamp) {
    const orderInputField = document.querySelector(
        `input[name*="${newSetTimestamp}"][name$="[set_number]"]`
    );

    const visibleSets = this.setFormFieldTargets.filter(
        (field) => field.style.display !== "none"
    );
    orderInputField.value = visibleSets.length;
  }

  setInitialInputs(newSetTimestamp) {
    this.setOrderField(newSetTimestamp)

    // add weight and reps to newly added sets
    const weightInputField = document.querySelector(
        `input[name*="${newSetTimestamp}"][name$="[weight]"]`
    );
    const repsInputField = document.querySelector(
        `input[name*="${newSetTimestamp}"][name$="[reps]"]`
    );

    const lastSet = this.setFormFieldTargets
        .filter((field) => field.style.display !== "none")
        .slice(-2, -1)[0];

    if (!lastSet) return;

    const lastWeightInput = lastSet.querySelector('input[name$="[weight]"]');
    const lastRepsInput = lastSet.querySelector('input[name$="[reps]"]');

    if (lastWeightInput && weightInputField) {
      weightInputField.value = lastWeightInput.value;
    }

    if (lastRepsInput && repsInputField) {
      repsInputField.value = lastRepsInput.value;
    }
  }

  onWeightChange(event) {
    const input = event.target;
    const value = parseFloat(input.value);

    const setWrapper = input.closest('[data-nested-set-form-target="setFormField"]');
    const orderInput = setWrapper.querySelector('input[name$="[set_number]"]');
    const order = orderInput.value;

    input.dataset.propagateWeight = "false";
    this.propagateChangeToSets("weight", value, order);
  }

  onRepsChange(event) {
    const input = event.target;
    const value = parseInt(input.value);

    const setWrapper = input.closest('[data-nested-set-form-target="setFormField"]');
    const orderInput = setWrapper.querySelector('input[name$="[set_number]"]');
    const order = orderInput.value;

    input.dataset.propagateReps = "false";
    this.propagateChangeToSets("reps", value, order);
  }

  propagateChangeToSets(fieldName, value, order) {
    this.setFormFieldTargets.forEach((field) => {
      if (field.style.display === "none") return;

      const input = field.querySelector(`input[name$="[${fieldName}]"]`);
      const currOrder = field.querySelector('input[name$="[set_number]"]').value;
      const inputNeedsPropagation = input.getAttribute(`data-propagate-${fieldName}`) !== "false";
      if (!inputNeedsPropagation || order > currOrder) return;

      input.value = value;
      input.setAttribute(`data-propagate-${fieldName}`, "true");
    });
  }
}
