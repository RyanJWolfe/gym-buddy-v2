import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workouts-toggle"
export default class extends Controller {
  switch(event) {
    // Allow normal clicks with meta/ctrl to open in new tab
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return

    event.preventDefault()

    const anchor = event.currentTarget
    const url = anchor.getAttribute('href')
    const frame = anchor.dataset.turboFrame || 'workouts_view'

    // Use Turbo to visit and update the URL, targeting the frame
    // Turbo.visit with frame: will perform a full-visit; instead use fetch and render into the frame
    fetch(url, {
      headers: { Accept: "text/vnd.turbo-frame.html" }
    })
      .then(response => response.text())
      .then(html => {
        const frameEl = document.getElementById(frame)
        if (frameEl) {
          frameEl.innerHTML = html
        } else {
          // fallback to a full visit if the frame isn't found
          Turbo.visit(url)
        }
        // push state so URL updates
        history.pushState({}, '', url)
      })
  }
}
