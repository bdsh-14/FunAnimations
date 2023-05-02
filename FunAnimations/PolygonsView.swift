import SwiftUI

struct PolygonsView: View {
	@State private var sides: Double = 4
	@State private var scale: Double = 1.0

	var body: some View {
		VStack {
			PolygonShape(sides: sides, scale: scale)
				.stroke(Color.purple, lineWidth: 5)
				.frame(width: 350, height: 400)
				.border(Color.black)
				.padding()

			Text("\(Int(sides)) sides, \(String(format: "%.2f", scale as Double)) scale")

			HStack(spacing: 20) {
				Button("2") {
					withAnimation(Animation.easeInOut(duration: 1.0)) {
						self.sides = 2.0
						self.scale = 1.0
					}
				}

				Button("3") {
					withAnimation(Animation.easeInOut(duration: 1.0)) {
						self.sides = 3.0
						self.scale = 1.0
					}
				}

				Button("7") {
					withAnimation(Animation.easeInOut(duration: 1.0)) {
						self.sides = 7.0
						self.scale = 1.0
					}
				}

				Button("10") {
					withAnimation(Animation.easeInOut(duration: 1.0)) {
						self.sides = 10.0
						self.scale = 1.0
					}
				}

			}
		}
		.navigationBarTitle("Polygons")
	}
}

struct PolygonShape: Shape {
	var sides: Double
	var scale: Double

	var animatableData: AnimatablePair<Double, Double> {
		get { AnimatablePair(sides, scale) }
		set {
			sides = newValue.first
			scale = newValue.second
		}
	}

	func path(in rect: CGRect) -> Path {
		// length hypotenuse
		let hypotenuse = Double(min(rect.width, rect.height)) / 2.0 * scale

		// center coordinates
		let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)

		var path = Path()

		for side in 0..<Int(sides) {
			let angle = (Double(side) * (360.0 / sides)) * (Double.pi / 180)

			// Calculate vertex
			let vertex = CGPoint(x: center.x + CGFloat(cos(angle) * hypotenuse),
								 y: center.y + CGFloat(sin(angle) * hypotenuse))

			if side == 0 {
				path.move(to: vertex) // move to first vertex
			} else {
				path.addLine(to: vertex) // draw line to next vertex
			}
		}

		// Drawing the polygon from a vertex instead of center so that we can close the path.

		path.closeSubpath()

		return path
	}
}

// Previews
struct PolygonsView_Previews: PreviewProvider {
	static var previews: some View {
		PolygonsView()
	}
}
