import { BridgeComponent, BridgeElement } from "@hotwired/strada"

export default class extends BridgeComponent {
  static component = "nav-menu"
  static targets = ["item"]

  connect() {
    this.element.classList.add("is-hidden")

    // About the icon property in the itemTargets
    // Sending the attribute to both apps is slightly unintuitive as we’ll ignore it on Android. We can check the 
    // current platform via the BridgeElement class, so it’s possible to send platform specific messages by 
    // namespacing data- attributes and writing some logic to that effect. In this case I’ve chosed to keep it simple,
    // but I’d recommend making this distinction for bigger applications.
    const items =
      this.itemTargets
        .map(item => new BridgeElement(item))
        .map((item, index) => ({
          title: item.title,
          icon: item.bridgeAttribute("icon"),
          index
        }))

    this.send("connect", { items }, message => {
      const selectedIndex = message.data.selectedIndex
      const selectedItem = new BridgeElement(
        this.itemTargets[selectedIndex]
      )

      selectedItem.click()
    })
  }

  disconnect() {
    this.send("disconnect")
  }
}
