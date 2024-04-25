import React from 'react'
import { Controller } from "@hotwired/stimulus"
import { createRoot } from 'react-dom/client';
import RichTextEditor from "../react/components/RichTextEditor";


// Connects to data-controller="rich-editor"
export default class extends Controller {
  connect() {
    console.log('connect rich editor2')
    const root = createRoot(this.element)
    root.render(<RichTextEditor />)
  }
}
