import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "heart",
    "heartActive",
    "heartInactive",
    "heartActiveModal",
    "heartInactiveModal",
  ];

  async toggleFavorite(evt) {
    evt.preventDefault();
    console.log("qfqsef");
    const eventId = evt.currentTarget.dataset.eventId;
    const response = await fetch(`/interests/${eventId}/favorite`);
    const data = await response.json();

    if (data.favorite) {
      // red heart
      this.heartActiveTargets.forEach((item) => {
        item.classList.add("d-none");
      });

      this.heartInactiveTargets.forEach((item) => {
        item.classList.remove("d-none");
      });

      // this.heartActiveTarget.classList.add("d-none");
      // this.heartInactiveTarget.classList.remove("d-none");
    } else {
      // empty heart
      this.heartTarget.classList.remove("favorited");

      // this.heartActiveTarget.classList.remove("d-none");
      // this.heartInactiveTarget.classList.add("d-none");

      this.heartActiveTargets.forEach((item) => {
        item.classList.remove("d-none");
      });

      this.heartInactiveTargets.forEach((item) => {
        item.classList.add("d-none");
      });
    }
  }
}
