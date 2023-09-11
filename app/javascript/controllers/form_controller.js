import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "fields" ]

    hide(e) {
        e.target.closest("[data-form-target='fields']").style = "display: none;"
    }
}
