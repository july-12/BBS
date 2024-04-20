import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["post", "comment", "favorite", "postLink"];
  connect() {
    console.log("connect dashbard");
  }
  changeTab(e) {
    switch (e.target) {
      case this.postTarget:
        console.log("post");
        this.postLinkTarget.click()
        break;
      case this.commentTarget:
        console.log("comment");
        break;
      case this.favoriteTarget:
        console.log("favorite");
        break;
      default:
        break;
    }
  }
}
