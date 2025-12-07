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
        input.setAttribute('value', index);
        index += 1;
      }
    });
  }

  setOrderField(timestamp) {
    const orderInputField = document.querySelector(
        `input[name*="${timestamp}"][name$="[set_number]"]`
    );

    const visibleSets = this.setFormFieldTargets.filter(
      (field) => field.style.display !== "none"
    );
    orderInputField.value = visibleSets.length;

    orderInputField.setAttribute('value', visibleSets.length);
  }
}
