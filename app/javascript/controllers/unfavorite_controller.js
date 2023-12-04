import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hearts"];

  connect() {
  }

  async deleteFavorite(evt) {
    const eventId = evt.currentTarget.dataset.eventId;
    const response = await fetch(`/interests/${eventId}/favorite`);
    const data = await response.json();
    //  Retirer la couleur du coeur
    evt.target.closest('.card-wrapper').remove();
  };
}
