import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "link" ]

  copyConfirmationLink(event) {
    event.preventDefault();
    this.linkTarget.select();
    document.execCommand("copy");

    // Todo: show tooltip for copied;
  }
}
