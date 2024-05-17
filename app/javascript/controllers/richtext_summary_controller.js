import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="richtext-summary"
export default class extends Controller {
  static values = { content: String };
  connect() {
    const div = document.createElement("div");
    div.innerHTML = this.contentValue;
    this.element.innerText = div.textContent;
  }
}
