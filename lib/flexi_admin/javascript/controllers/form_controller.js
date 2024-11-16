import { Controller } from "@hotwired/stimulus";
import { fetchTurboContent } from "../utils";

// Connects to data-controller="form"
export default class extends Controller {
  static values = {
    resourcePath: String,
  };

  enable(event) {
    fetchTurboContent(event, this.resourcePathValue);
  }

  disable(event) {
    fetchTurboContent(event, this.resourcePathValue);
  }
}
