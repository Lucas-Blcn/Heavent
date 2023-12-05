import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"];

  connect() {

  }
  async toggleFavorite(evt) {
    evt.preventDefault();
    const eventId = evt.currentTarget.dataset.eventId
    const response = await fetch(`/interests/${eventId}/favorite`);
    const data = await response.json();

    if (data.favorite) {
      console.log("not yet fav")
      // red heart
      this.heartTarget.classList.add('favorited');
    } else {
      console.log("already fav")
      // empty heart
      this.heartTarget.classList.remove('favorited');
      // if (data.page === 'favorite') {

      // }
    }
  };
}
