import { Controller } from "@hotwired/stimulus"

// This controller handles the workout duration timer
export default class extends Controller {
  static targets = ["display"]
  static values = { start: Number }

  connect() {
    // Start the timer when controller connects
    this.startTimer()
  }

  disconnect() {
    // Clean up the timer when controller disconnects
    this.stopTimer()
  }

  startTimer() {
    // Update timer immediately on connect
    this.updateTimer()

    // Set interval to update timer every second
    this.timerInterval = setInterval(() => {
      this.updateTimer()
    }, 1000)
  }

  stopTimer() {
    if (this.timerInterval) {
      clearInterval(this.timerInterval)
    }
  }

  updateTimer() {
    const now = Math.floor(Date.now() / 1000) // Current time in seconds
    const startTime = this.startValue // Get the start time from data attribute
    const elapsedSeconds = now - startTime

    const hours = Math.floor(elapsedSeconds / 3600)
    const minutes = Math.floor((elapsedSeconds % 3600) / 60)
    const seconds = elapsedSeconds % 60

    // Format as HH:MM:SS
    const formattedTime = [
      hours.toString().padStart(2, '0'),
      minutes.toString().padStart(2, '0'),
      seconds.toString().padStart(2, '0')
    ].join(':')

    // Update the display target with formatted time
    this.displayTarget.textContent = formattedTime
  }
}
