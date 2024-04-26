import React from 'react'
import { createRoot } from 'react-dom/client';
import { Controller } from "@hotwired/stimulus"
import RichTextEditor from "../react/components/RichTextEditor"

// Connects to data-controller="rich-text-preview"
export default class extends Controller {
  static values = { text: String }
  connect() {
    const root = createRoot(this.element)
    root.render(<RichTextEditor defaultContent={this.textValue} readOnly={true} />)
  }
}
