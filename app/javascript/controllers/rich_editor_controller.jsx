import React from "react";
import { Controller } from "@hotwired/stimulus";
import { createRoot } from "react-dom/client";
import RichTextEditor from "../react/components/RichTextEditor";
import { editorEventKey } from "./utils/event";
import { CLEAR_EDITOR_COMMAND } from 'lexical'

// Connects to data-controller="rich-editor"
export default class extends Controller {
  static targets = ["editor", "content", "submitBtn"];
  static editorState = null;
  initialize() {
    this.editorRef = { current: null };
  }
  connect() {
    const root = createRoot(this.editorTarget);
    root.render(
      <RichTextEditor
        ref={this.editorRef}
        defaultContent={this.contentTarget.value || undefined}
        onChange={this.onChange.bind(this)}
      />
    );
    this.element.addEventListener(
      editorEventKey,
      this.listenEditor.bind(this),
      false
    );
  }
  listenEditor(e) {
    const editor = this.editorRef.current;
    setTimeout(() => {
      editor.focus()
    }, 1000);
  }
  onChange(editorState) {
    this.editorState = editorState;
    this.contentTarget.value = JSON.stringify(editorState);
  }
  async uploadImage(imageNode) {
    const formData = new FormData();
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    formData.append(`phone[image]`, imageNode.__file);
    try {
      const response = await fetch("/upload", {
        method: "POST",
        mode: "cors", // no-cors, *cors, same-origin
        // cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
        headers: {
          // "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: formData,
      });
      if (!response.ok) {
        throw new Error("request was not ok!");
      }
      const data = await response.json();
      return data.url;
    } catch (error) {
      console.error("Error", error);
    }
  }
  async submit(e) {
    e.preventDefault();
    let imageNodes = [];
    if (this.editorState) {
      this.editorState._nodeMap.forEach(
        (node) =>
          node.__type === "image" && !!node.__file && imageNodes.push(node)
      );
      if (imageNodes.length > 0) {
        const imageUrls = await Promise.all(
          imageNodes.map((imageNode) => this.uploadImage(imageNode))
        );
        this.editorRef.current.update(
          () => {
            imageUrls.forEach((url, index) => imageNodes[index].setSrc(url));
          },
          { discrete: true }
        );
      }
    }
    this.editorRef.current.dispatchCommand(CLEAR_EDITOR_COMMAND, undefined);
    this.submitBtnTarget.click();
  }
}
