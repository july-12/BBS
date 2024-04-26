import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
  }
  clear() {
    this.element.reset() 
  }
}
