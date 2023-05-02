import SwiftUI

struct ScaleMovement: View {
	@State var value: CGFloat = 0.0

	@State var offSet: CGFloat = 0.0

	@State var skew: CGFloat = 0.0

    var body: some View {
		VStack(alignment: .leading) {
			//Image(systemName: "face.smiling.inverse")
			Image("pikachu")
				.resizable()
				.foregroundColor(.yellow)
				.frame(width: 100, height: 100)
				.offset(x: -60)

				.onAppear {
					withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(2.0)) {
						offSet = 150
						skew = 0.5
					}
				}
			.modifier(SkewedOffset(offset: offSet, skew: skew))
		}
    }
}

struct SkewedOffset: GeometryEffect {
	var offset: CGFloat
	var skew: CGFloat

	var animatableData: AnimatablePair<CGFloat, CGFloat> {
		get { AnimatablePair(offset, skew) }
		set {
			offset = newValue.first
			skew = newValue.second
		}
	}

	func effectValue(size: CGSize) -> ProjectionTransform {
		let transformTranslate = CGAffineTransform(translationX: offset, y: 0)
		let transformRotate = CGAffineTransform(rotationAngle: Double.pi * 0.5)

		return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
	//	return ProjectionTransform(transformTranslate)
	//	return ProjectionTransform(transformRotate)

	}
}

struct ScaleMovement_Previews: PreviewProvider {
    static var previews: some View {
        ScaleMovement()
    }
}
