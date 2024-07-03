import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-element"
export default class extends Controller {
  remove() { // Called by the "data-action" attribute
    this.element.remove();
  }
}
