import { Controller } from "@hotwired/stimulus";
import { fetchTurboContent } from "../utils";

// Connects to data-controller="switch-view"
export default class extends Controller {
  static values = {
    resourcePath: String,
  };

  connect() {}

  switch(event) {
    fetchTurboContent(event, this.resourcePathValue);
  }
}
