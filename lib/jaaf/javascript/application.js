// Using esbuild and Bootstrap in a Rails 7 Project by Replacing the Default Importmap
// https://medium.com/@rwubakwanayoolivier/using-esbuild-and-bootstrap-in-a-rails-7-project-by-replacing-the-default-importmap-cfc1f54e83ce

import "@hotwired/turbo-rails";
import "bootstrap";
import * as ActiveStorage from "@rails/activestorage";
import "./controllers";
import "./utils";

ActiveStorage.start();
window.bootstrap = require("bootstrap");
