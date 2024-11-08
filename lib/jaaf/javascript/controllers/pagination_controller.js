import { Controller } from "@hotwired/stimulus";
import { fetchContent } from "../utils";

// Connects to data-controller="pagination"
export default class extends Controller {
  connect() {}

  paginate(event) {
    const path = event.target.dataset.resourcePath;

    fetchContent(event, path);
  }
}
