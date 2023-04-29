import SwiftUI

struct CutoutCornerRects: View {

	@State var cornerRadius: CFloat = 0.0

    var body: some View {
		CutOutCornerRectangle(cornerRadius: CGFloat(self.cornerRadius))
			.fill(Color.pink)
			.onAppear{
				withAnimation (Animation.easeOut(duration: 0.4).repeatForever(autoreverses: true)){
					self.cornerRadius = 40.0
				}
			}
			.padding()
			.frame(width: 400, height: 300)
			.padding()
			.navigationTitle("Animatable data rect-out rect")
    }
}

	struct CutOutCornerRectangle: Shape {
		var cornerRadius: CGFloat

	var animatableData: CGFloat {
		get { cornerRadius }
		set { cornerRadius = newValue }
	}

	// Drawing the rectangle
	func path(in rect: CGRect) -> Path {
		var path = Path()

		let height = rect.height
		let width = rect.width

		path.move(to: CGPoint(x: cornerRadius, y: 0))
		path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))

		path.addQuadCurve(to: CGPoint(x: width, y: cornerRadius),
						  control: CGPoint(x: width-cornerRadius, y: cornerRadius))

		path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
		path.addQuadCurve(to: CGPoint(x: width - cornerRadius, y: height),
						  control: CGPoint(x: width - cornerRadius, y: height - cornerRadius))

		path.addLine(to: CGPoint(x: cornerRadius,
								 y: height))
		path.addQuadCurve(to: CGPoint(x: 0, y: height-cornerRadius), control: CGPoint(x: cornerRadius, y: height - cornerRadius))

		path.addLine(to: CGPoint(x: 0, y: cornerRadius))
		path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint(x: cornerRadius, y: cornerRadius))

		return path
	}
}

struct RoundedCornerRects_Previews: PreviewProvider {
    static var previews: some View {
        CutoutCornerRects()
    }
}
