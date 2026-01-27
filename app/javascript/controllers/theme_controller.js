import { Controller } from "@hotwired/stimulus"
import { lightTheme, darkTheme, systemPreference } from "../helpers/toggle_theme";

export default class extends Controller {
  selectLight() {
    lightTheme()
  }

  selectDark() {
    darkTheme()
  }

  selectSystem() {
    systemPreference()
  }
}
