import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "link"];
  connect() {
    const search = new URLSearchParams(location.search);
    this.inputTarget.value = search.get("q");
  }
  inputEnter(e) {
    this.linkTarget.href = `/search?q=${this.inputTarget.value}`;
    this.linkTarget.click();
  }
}
