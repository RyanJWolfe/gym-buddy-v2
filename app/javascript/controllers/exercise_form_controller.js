import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelect", "customCategory", "equipmentSelect", "customEquipment"]
  
  connect() {
    this.toggleCustomFields()
  }
  
  toggleCustomFields() {
    if (this.hasCategorySelectTarget) {
      const showCustomCategory = this.categorySelectTarget.value === "Other"
      this.customCategoryTarget.classList.toggle("hidden", !showCustomCategory)
    }
    
    if (this.hasEquipmentSelectTarget) {
      const showCustomEquipment = this.equipmentSelectTarget.value === "Other"
      this.customEquipmentTarget.classList.toggle("hidden", !showCustomEquipment)
    }
  }
} 