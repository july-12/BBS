import React from "react";
import { Controller } from "@hotwired/stimulus";
import { createRoot } from "react-dom/client";
import RichTextEditor from "../react/components/RichTextEditor";

// Connects to data-controller="rich-editor"
export default class extends Controller {
  static targets = ["editor", "content", "submitBtn"];
  static editorState = null;
  connect() {
    const root = createRoot(this.editorTarget);
    root.render(
      <RichTextEditor
        defaultContent={this.contentTarget.value || undefined}
        onChange={this.onChange.bind(this)}
      />
    );
  }
  onChange(editorState, editor) {
    console.log(editorState);
    this.editorState = editorState;
    this.contentTarget.value = JSON.stringify(editorState);
  }
  uploadImage(rawData) {
    const formData = new FormData();
    formData.append(`phone[image]`, rawData);
    return fetch("/upload", { method: "POST", body: formData }).then((res) =>
      console.log(res.json())
    );
  }
  async submit() {
    let imageNodes = [];
    if (this.editorState) {
      this.editorState._nodeMap.forEach(
        (node) => node.__type === "image" && imageNodes.push(node)
      );
      if (imageNodes.length > 0) {
        const imageUrls = await Promise.all[
          imageNodes.map((imageNode) => this.uploadImage(imageNode.__src))
        ];
      }
    }
    console.log("...", imageUrls);
    console.log(imageUrls);

    // this.submitBtnTarget.click();
  }
}
