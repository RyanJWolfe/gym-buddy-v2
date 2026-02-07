import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workouts-toggle"
export default class extends Controller {
  switch(event) {
    console.log("switching")
  }
}
