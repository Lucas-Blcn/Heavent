import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [
    "card",
    "modal",
    "close",
    "modalContent",
    "description",
    "btn",
  ];

  connect() {}

  show() {
    this.modalTarget.style.display = "block";
    // this.modalTarget.classList.add("show-modal")
    setTimeout(() => {
      this.modalContentTarget.classList.add("show-modal-content");
    }, 10);
  }

  close() {
    setTimeout(() => {
      this.modalContentTarget.classList.remove("show-modal-content");
      this.modalTarget.classList.remove("show-modal");
    }, 10);

    setTimeout(() => {
      this.modalTarget.style.display = "none";
    }, 400);
  }

  toggleDescription() {
    this.descriptionTarget.classList.toggle("d-none");
  }
}
