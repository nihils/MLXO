package visual;

import flash.events.MouseEvent;

class Board 
{
	public function new() {
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	private function onMouseDown(event:MouseEvent):Void {
		trace("On Mouse Down");
		this.graphics.moveTo(event.localX, event.localY);
		this.graphics.lineStyle(2, 0x0000FF);
		this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	private function onMouseMove(event:MouseEvent):Void {
		trace("On Mouse Move");
		this.graphics.lineTo(event.localX, event.localY);
	}
	private function onMouseUp(event:MouseEvent):Void {
		trace("On Mouse Up");
		this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
} 
