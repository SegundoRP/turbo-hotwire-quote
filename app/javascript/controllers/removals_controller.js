import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}


// now i realized this controller is not necessary for disappear flash messages
// maybe in the first release it was necessary
