import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "link" ]

  copyConfirmationLink(event) {
    event.preventDefault();
    this.linkTarget.select();
    document.execCommand("copy");

    this.showTooltip(event);
  }

  showTooltip(event) {
    let self = this;
    let tooltipElement = event.target;
    let defaultTitle = tooltipElement.attributes['data-bs-original-title'].value
    let tooltip = this.setTooltipTitle(tooltipElement, 'Copied');

    tooltip.show();

    setTimeout(function() {
      tooltip = self.setTooltipTitle(tooltipElement, defaultTitle);
      tooltip.update();
    }, 1000);
  }

  setTooltipTitle(tooltipElement, title) {
    tooltipElement.setAttribute('data-bs-original-title', title);

    return bootstrap.Tooltip.getInstance(tooltipElement);
  }
}
