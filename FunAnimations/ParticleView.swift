//
//  ConfettiView.swift
//  FunAnimations
//
//  Created by Bidisha Biswas on 4/23/23.
//

import SwiftUI

struct ParticleView: View {
	var body: some View {
		ZStack {
			ForEach (0..<100) { _ in
				Image(systemName: "heart.fill")
					.foregroundColor(.pink)
					.modifier(ParticleEffect())
			}
		}
	}
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ParticleView()
    }
}

struct ParticleMotionEffect: GeometryEffect {
	var time: Double
	let v0: Double = Double.random(in: 40...180) // initial speed
	let alpha: Double = Double.random(in: 0.0...Double.pi * 2) // throw angle
	let g: Double = 0.81 // gravity

	var animatableData: Double {
		get { time }
		set { time = newValue }
	}

	func effectValue(size: CGSize) -> ProjectionTransform {
		let dx = v0 * time * cos(alpha)
		let dy = v0 * tan(alpha) * time - 0.5 * g * time * time * 10

		let affineTransform = CGAffineTransform(translationX: dx, y: -dy)
		return ProjectionTransform(affineTransform)
	}
}

struct ParticleEffect: ViewModifier {
	@State var time: Double = 0.0

	let maxDuration: Double = 2.0

	func body(content: Content) -> some View {
		content
			.modifier(ParticleMotionEffect(time: self.time))
			.animation(.easeInOut(duration: self.maxDuration)
				.repeatForever()
				.delay(Double.random(in: 0...maxDuration)),
					   value: self.time)
			.onAppear {
				self.time = maxDuration
			}
	}
}
