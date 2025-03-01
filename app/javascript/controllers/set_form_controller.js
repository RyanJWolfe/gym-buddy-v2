import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["weight", "reps", "volume"]
  
  connect() {
    this.calculateVolume()
  }
  
  calculateVolume() {
    if (this.hasWeightTarget && this.hasRepsTarget && this.hasVolumeTarget) {
      const weight = parseFloat(this.weightTarget.value) || 0
      const reps = parseInt(this.repsTarget.value) || 0
      const volume = weight * reps
      
      this.volumeTarget.textContent = `${volume.toFixed(2)} kg`
    }
  }
} 