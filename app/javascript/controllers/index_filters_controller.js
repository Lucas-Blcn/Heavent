import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index-filters"
export default class extends Controller {
  static targets = ["card", "form", "input", "results"];

  connect() {
    console.log("Hello");
    const tags = this.data.get("tags");
    console.log(tags);
  }

  toggle() {
    const filters = [];
    this.inputTargets.forEach((x) => {
      if (x.checked === true) {
        filters.push(x.value);
      }
    });

    const url = `${this.formTarget.action}?query=${filters}`;

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
