import SwiftUI

struct WaterLevelShape: Shape {
	var waterLevel: CGFloat // 0..1
	let waveOffset: CGFloat // radians

	var animatableData: CGFloat {
		get { return self.waterLevel }
		set { self.waterLevel = newValue }
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()

		let waterHeight = rect.size.height * waterLevel
		let amplitudeFactor = min(waterLevel * 0.1, (1-waterLevel) * 0.1)
		let waveAmplitude = waterHeight * amplitudeFactor

		path.move(to: CGPoint(x: 0, y: rect.height))
		for i in 0...100 {
			let xNorm = CGFloat(i)/100
			let x = xNorm * rect.width
			let y = waterHeight + waveAmplitude * sin(xNorm * CGFloat.pi * +(waterLevel + waveOffset) * CGFloat.pi * 5)

			path.addLine(to: CGPoint(x: x, y: y))
		}
		path.addLine(to: CGPoint(x: rect.width, y: rect.height))

		return path
	}
}
