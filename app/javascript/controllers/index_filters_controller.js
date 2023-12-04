import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index-filters"
export default class extends Controller {
  static targets = ["card", "form"];

  connect() {
    console.log("Hello");
    const tags = this.data.get("tags");
    console.log(tags);
  }

  toggle(ev) {
    console.log("coucou");
    ev.preventDefault();
    console.log(this.formTarget);
    // const filter = new URLSearchParams({
    //   tags:,
    //   type_of_price:
    // })


    fetch(this.formTarget.action, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
      body: new FormData(this.formTarget),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      });
    // this.cardTarget.classList.add("d-none");
    // const tags = this.data.get("tags");
  }
}
