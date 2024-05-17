import { Controller } from "@hotwired/stimulus"
import { debounce } from 'lodash'

// Connects to data-controller="advance-search"
export default class extends Controller {
  connect() {
    console.log('advance-search connect')
    this.submit = debounce(this.submit.bind(this), 300)
  }

  submit() {
    console.log('geso hre simit')
    this.element.requestSubmit()
  }
}
