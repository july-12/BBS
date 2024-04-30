import { Controller } from "@hotwired/stimulus";
import { editorEvent } from "./utils/event";

// Connects to data-controller="comment-new"
export default class extends Controller {
  static targets = ["richEditor", "reply", "subReply"];
  reply(e) {
    const { replyId, subCommentId } = e.target.dataset;
    this.replyTarget.value = replyId;
    this.subReplyTarget.value = subCommentId;
    this.richEditorTarget.scrollIntoView({ behavior: "smooth" });
    this.richEditorTarget.dispatchEvent(editorEvent);
  }
}
