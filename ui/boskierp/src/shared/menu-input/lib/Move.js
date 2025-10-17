


class Move {
  constructor() { }

  isInViewport(element) {
    const rect = element.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }

  Show = (e, i) => {
    if (this.currentMenu) this.currentMenu.style.zIndex = ''
    this.currentMenu = document.getElementById(`menu-${i}`)
    this.currentMenu.style.zIndex = '40'
  }

  Start = (e, i) => {
    if (this.currentMenu) this.currentMenu.style.zIndex = ''
    this.currentMenu = document.getElementById(`menu-${i}`)
    this.mouseDown = true
    this.offsetX = e.clientX - this.currentMenu.offsetLeft;
    this.offsetY = e.clientY - this.currentMenu.offsetTop;
    this.currentMenu.style.zIndex = '40'
  }

  End = (e) => {
    this.mouseDown = false
  }

  Update = (event) => {
    if (this.mouseDown) {
      var eventDoc, doc, body;

      event = event || window.event;

      if (event.pageX == null && event.clientX != null) {
        eventDoc = (event.target && event.target.ownerDocument) || document;
        doc = eventDoc.documentElement;
        body = eventDoc.body;

        event.pageX = event.clientX +
          (doc && doc.scrollLeft || body && body.scrollLeft || 0) -
          (doc && doc.clientLeft || body && body.clientLeft || 0);
        event.pageY = event.clientY +
          (doc && doc.scrollTop || body && body.scrollTop || 0) -
          (doc && doc.clientTop || body && body.clientTop || 0);
      }

      let lastX = this.currentMenu.style.left
      let lastY = this.currentMenu.style.top
      let targetX = event.clientX - this.offsetX
      let targetY = event.clientY - this.offsetY

      this.currentMenu.style.left = (targetX) + "px"

      if (!this.isInViewport(this.currentMenu)) {
        this.currentMenu.style.left = lastX
      }

      this.currentMenu.style.top = (targetY) + "px"

      if (!this.isInViewport(this.currentMenu)) {
        this.currentMenu.style.top = lastY
      }
    }
  }
}

export default new Move()
