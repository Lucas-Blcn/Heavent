import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="logo-effect"
export default class extends Controller {
  connect() {
    const points = Array.from(this.element.querySelectorAll(".cls-1"));
    // points.forEach(point => {
    //   point.classList.remove("d-none")
    // });
    const shuffledPoints = points.sort((a, b) => 0.5 - Math.random());
    shuffledPoints.forEach(point => {
      const index = shuffledPoints.indexOf(point)
      const delays = [4,6,8,10];
      setTimeout(() => {
        point.classList.remove("d-none");
      }, delays[Math.floor(Math.random() * delays.length)]*index);
    });
    // console.log(shuffledPoints);

  }
}
