import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  connect() {
    console.log('connect2')
  }
  clear() {
    console.log('clear.2.')
    this.element.reset() 
  }
}
