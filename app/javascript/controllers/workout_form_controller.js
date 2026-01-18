import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="workout-form"
export default class extends Controller {
  static values = {
    workoutId: Number
  }

  connect() {
  }

  addExercises(event) {
    const selectedExerciseIds = event.detail.exerciseIds;
    if (!selectedExerciseIds || selectedExerciseIds.length === 0) return;

    const url = `/workouts/${this.workoutIdValue}/exercise_logs`;
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({exercise_ids: selectedExerciseIds})
    })
        .then(r => r.text())
        .then(html => {
          Turbo.renderStreamMessage(html)
        })
  }
}
