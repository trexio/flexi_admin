import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="trix"
export default class extends Controller {
  static values = { disabled: Boolean, collapsed: Boolean };
  static targets = ["editor", "trigger", "container"];

  connect() {
    if (this.disabledValue === false) {
      // Set background color to white
      this.editorTarget.style.backgroundColor = "white";
    }
  }

  toggleCollapse() {
    if (this.collapsedValue === true) {
      this.containerTarget.classList.remove("collapsed");
      this.containerTarget.classList.add("expanded");
      this.collapsedValue = false;
    } else {
      this.containerTarget.classList.remove("expanded");
      this.containerTarget.classList.add("collapsed");
      this.collapsedValue = true;
    }

    if (this.triggerTarget.innerHTML === "rozbalit") {
      this.triggerTarget.innerHTML = "skrýt";
    } else {
      this.triggerTarget.innerHTML = "rozbalit";
    }
  }
}
