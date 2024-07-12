import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tags"
export default class extends Controller {
  static targets = ["template", "container", "input"];
  addTag() { // Called by the "data-action" attribute
    var input = this.inputTarget.value;
    var templateHtml = this.templateTarget.innerHTML;
    templateHtml = templateHtml.replace(/{value}/g, input);
    this.containerTarget.insertAdjacentHTML('beforeend', templateHtml);
    this.inputTarget.value = "";
  }
}
