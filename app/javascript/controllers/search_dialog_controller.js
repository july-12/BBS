import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-dialog"
export default class extends Controller {
  static targets = ["dialog", "close"]
  connect() {
    console.log('search dialog connect')
  }
  open() {
    this.element.classList.remove('hidden')
    this.dialogTarget.showModal()
  }

  close() {
    this.element.classList.add('hidden')
  }
}
