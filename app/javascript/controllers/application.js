import { Application } from "@hotwired/stimulus"
import RailsNestedForm from "@stimulus-components/rails-nested-form"
import Dialog from "@stimulus-components/dialog"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
application.register("nested-form", RailsNestedForm)
application.register("dialog", Dialog)

export { application }
