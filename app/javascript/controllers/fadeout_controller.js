import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fadeout"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add('fadein-hidden')
    }, 2000)
  }
}
