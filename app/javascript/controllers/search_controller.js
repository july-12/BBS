import { Controller } from "@hotwired/stimulus";
import { globalSearchDialogEvent } from './utils/event'

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', this.focus.bind(this), false)
  }
  focus() {
    document.dispatchEvent(globalSearchDialogEvent)
  }
}
