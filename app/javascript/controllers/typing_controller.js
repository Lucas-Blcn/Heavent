import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['text']
  static values = { text: String }

  connect() {
    this.i = 0
    this.speed = 50;
    this.typing();
  }

  typing() {
    if (this.i < this.textValue.length) {
      this.textTarget.innerHTML += this.textValue.charAt(this.i);
      this.i++;

      setTimeout(this.typing.bind(this), this.speed);
    }
  }
}
