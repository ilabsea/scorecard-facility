import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  copyConfirmationLink(event) {
    event.preventDefault();
    let input = event.target.previousElementSibling;
    input.select();
    document.execCommand("copy");

    // Todo: show tooltip for copied;
  }
}
