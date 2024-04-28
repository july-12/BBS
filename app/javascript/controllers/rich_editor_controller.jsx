import React from 'react'
import { Controller } from "@hotwired/stimulus"
import { createRoot } from 'react-dom/client';
import RichTextEditor from "../react/components/RichTextEditor";


// Connects to data-controller="rich-editor"
export default class extends Controller {
  static targets = ["editor", "content"]
  connect() {
    const root = createRoot(this.editorTarget)
    root.render(<RichTextEditor defaultContent={this.contentTarget.value || undefined} onChange={this.textChange.bind(this)}/>)
  }
  textChange(value) {
    // console.log('value', value)
    this.contentTarget.value = value
  }
  submit(e) {
    e.preventDefault()
  }
}
