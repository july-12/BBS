import { Controller } from "@hotwired/stimulus"
import { globalSearchDialogEventKey } from './utils/event'

// Connects to data-controller="search-dialog"
export default class extends Controller {
  static targets = ["dialog", "close", "queryForm"]
  connect() {
    this.listenEvent()
  }
  listenEvent() {
    document.addEventListener(globalSearchDialogEventKey, this.open.bind(this), false);
    this.dialogTarget.addEventListener('close', this.close.bind(this), false) // close by esc
  }
  open(e) {
    if(e.key === 'k' || e.type === globalSearchDialogEventKey) {
      document.body.classList.add("overflow-hidden")
      this.element.classList.remove('hidden')
      this.dialogTarget.showModal()
    }
  }

  close() {
    this.queryFormTarget.reset()
    this.queryFormTarget.requestSubmit()
    this.element.classList.add('hidden')
    document.body.classList.remove("overflow-hidden")
  }
}
