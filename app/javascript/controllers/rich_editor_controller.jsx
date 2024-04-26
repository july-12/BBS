import React from 'react'
import { Controller } from "@hotwired/stimulus"
import { createRoot } from 'react-dom/client';
import RichTextEditor from "../react/components/RichTextEditor";


// Connects to data-controller="rich-editor"
export default class extends Controller {
  static targets = ["editor"]
  connect() {
    console.log('connect rich editor2')
    const root = createRoot(this.editorTarget)
    root.render(<RichTextEditor />)
  }
  submit(e) {
    console.log('geso re')
    e.preventDefault()
  }
}
