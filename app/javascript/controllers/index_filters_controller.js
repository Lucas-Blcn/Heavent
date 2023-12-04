import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index-filters"
export default class extends Controller {
  static targets = ["card", "form", "input", "results", "priceInput"];

  connect() {}

  toggle() {
    const filters = [];
    let freeFilter = false;
    this.inputTargets.forEach((x) => {
      if (x.checked === true) {
        filters.push(x.value);
      }
    });

    if (this.priceInputTarget.checked === true) {
      freeFilter = true;
    }
    console.log(freeFilter);
    const url = `${this.formTarget.action}?query=${filters}&free=${freeFilter}`;

    fetch(url, {
      method: "GET",
      headers: {
        Accept: "text/plain",
      },
    })
      .then((response) => response.text())
      .then((data) => {
        this.resultsTarget.innerHTML = data;
      });
  }
}
