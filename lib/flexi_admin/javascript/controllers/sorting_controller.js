import { Controller } from "@hotwired/stimulus";
import { fetchTurboContent } from "../utils";

// Connects to data-controller="sorting"
export default class extends Controller {
  static values = {
    sortPath: String,
  };

  // connect() {}

  sort(event) {
    event.preventDefault();

    fetchTurboContent(event, this.sortPathValue);
  }
}
