import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="twinkle-new-comment"
export default class extends Controller {
  connect() {
    const liTag = this.element.firstElementChild;
    liTag.scrollIntoView({
      behavior: "smooth",
      block: "center",
      inline: "nearest",
    });
    liTag.classList.add("twinkle");
    // setTimeout(() => {
    //   liTag.classList.remove("twinkle");
    // }, 2000);
  }
}
