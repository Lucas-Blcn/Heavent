import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"];

  connect() {

  }
  async toggleFavorite(evt) {
    const eventId = evt.currentTarget.dataset.eventId
    const response = await fetch(`/interests/${eventId}/favorite`);
    const data = await response.json();

    if (data.favorite) {
      // red heart
      this.heartTarget.classList.add("favorited");
    } else {
      // empty heart
      this.heartTarget.classList.remove("favorited");
    }
  };
}
