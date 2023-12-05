import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["card", "modal", "close"];

  connect() {}

  show() {
    this.modalTarget.style.display = "block";
  }

  close() {
    this.modalTarget.style.display = "none";
  }
}
