import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-new"
export default class extends Controller {
  static targets = ["item", "form", "reply", "sub_reply"]
  connect() {
    console.log('comment new connect')
  }

  reply(e) {
    console.log('relay', e)
    const replyId = e.target.dataset.replyId
    this.replyTarget.value = replyId
    this.formTarget.scrollIntoView({ behavior: "smooth" })
  }
}
