import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    //Set a delay to hide the toast message after 5 seconds (5000 milliseconds)
    setTimeout(() => {
      this.element.classList.add("slide-out");
      this.element.addEventListener(
        "transitionend",
        () => {
          this.element.style.display = "none";
        },
        { once: true }
      );
    }, 5000);
  }
}
