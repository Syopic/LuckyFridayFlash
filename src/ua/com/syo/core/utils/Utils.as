package ua.com.syo.core.utils {
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Utils {
		/**
		 * Bounding box of points array
		 */
		public static function getBoundingBox(points:Array):Rectangle {
			var xMin:Number = Infinity;
			var yMin:Number = Infinity;
			var xMax:Number = -Infinity;
			var yMax:Number = -Infinity;
			var j:int;
			if (points[0] is Point) {
				for (j = 0; j < points.length; j++) {
					xMin = Math.min(xMin, points[j].x);
					yMin = Math.min(yMin, points[j].y);
					xMax = Math.max(xMax, points[j].x);
					yMax = Math.max(yMax, points[j].y);
				}
			} else {
				for (j = 0; j < points.length; j += 2) {
					xMin = Math.min(xMin, points[j]);
					yMin = Math.min(yMin, points[j + 1]);
					xMax = Math.max(xMin, points[j]);
					yMax = Math.max(yMin, points[j + 1]);
				}
			}
			var w:Number = xMax - xMin;
			var h:Number = yMax - yMin;
			var result:Rectangle = new Rectangle(xMin, yMin, w, h);

			return result;
		}

		public static function brightenColor(hexColor:Number, percent:Number):Number {
			if (isNaN(percent)) {
				percent = 0;
			}
			if (percent > 100) {
				percent = 100;
			}
			if (percent < 0) {
				percent = 0;
			}

			var factor:Number = percent / 100;
			var rgb:Object = hexToRgb(hexColor);

			rgb.r += (255 - rgb.r) * factor;
			rgb.b += (255 - rgb.b) * factor;
			rgb.g += (255 - rgb.g) * factor;

			return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
		}

		public static function darkenColor(hexColor:Number, percent:Number):Number {
			if (isNaN(percent)) {
				percent = 0;
			}
			if (percent > 100) {
				percent = 100;
			}
			if (percent < 0) {
				percent = 0;
			}

			var factor:Number = 1 - (percent / 100);
			var rgb:Object = hexToRgb(hexColor);

			rgb.r *= factor;
			rgb.b *= factor;
			rgb.g *= factor;

			return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
		}

		public static function rgbToHex(r:Number, g:Number, b:Number):Number {
			return (r << 16 | g << 8 | b);
		}

		public static function hexToRgb(hex:Number):Object {
			return {r: (hex & 0xff0000) >> 16, g: (hex & 0x00ff00) >> 8, b: hex & 0x0000ff};
		}

		public static function brightness(hex:Number):Number {
			var max:Number = 0;
			var rgb:Object = hexToRgb(hex);
			if (rgb.r > max) {
				max = rgb.r;
			}
			if (rgb.g > max) {
				max = rgb.g;
			}
			if (rgb.b > max) {
				max = rgb.b;
			}
			max /= 255;
			return max;
		}
	}
}

