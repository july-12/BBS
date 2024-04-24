import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-password"
export default class extends Controller {
  reset(e) {
    if(e.detail.success) {
      this.element.reset()
    }
  }
}
