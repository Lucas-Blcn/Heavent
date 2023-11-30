import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"];

  connect() {

    console.log("hello")

  }

  toggleFavorite() {
    // this.heartTarget.innerText = "fa-solid fa-heart"
    this.heartTarget.classList.toggle("favorited");
    console.log(this.heartTarget.value);
  };

}
