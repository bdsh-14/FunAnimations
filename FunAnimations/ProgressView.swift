import SwiftUI

struct ProgressView: View {
	@State private var percent: CGFloat = 0

	var body: some View {
		VStack {
			Spacer()
			Color.clear.overlay(Indicator(pct: self.percent))

			Spacer()
			HStack(spacing: 10) {
				Button {
					withAnimation(.easeInOut(duration: 1.0)) { self.percent = 0 }
				} label: {
					Text("0%").font(.headline)
				}

				Button {
					withAnimation(.easeInOut(duration: 1.0)) { self.percent = 0.27 }
				} label: {
					Text("27%").font(.headline)
				}

				Button {
					withAnimation(.easeInOut(duration: 1.0)) { self.percent = 1.0 }
				} label: {
					Text("100%").font(.headline)
				}
			}
		}.navigationBarTitle("Progress View")
	}
}

struct Indicator: View {
	var pct: CGFloat

	var body: some View {
		return Circle()
			.fill(LinearGradient(gradient: Gradient(colors: [.blue, .pink, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
			.frame(width: 150, height: 150)
			.modifier(PercentageIndicator(pct: self.pct))
	}
}

struct PercentageIndicator: AnimatableModifier {
	var pct: CGFloat = 0

	var animatableData: CGFloat {
		get { pct }
		set { pct = newValue }
	}

	func body(content: Content) -> some View {
		content
			.overlay(ArcShape(pct: pct).foregroundColor(.red))
			.overlay(LabelView(pct: pct))
	}

	struct ArcShape: Shape {
		let pct: CGFloat

		func path(in rect: CGRect) -> Path {

			var p = Path()

			p.addArc(center: CGPoint(x: rect.width / 2.0, y:rect.height / 2.0),
					 radius: rect.height / 2.0 + 5.0,
					 startAngle: .degrees(0),
					 endAngle: .degrees(360.0 * Double(pct)), clockwise: false)

			return p.strokedPath(.init(lineWidth: 10, dash: [6, 3], dashPhase: 10))
		}
	}

	struct LabelView: View {
		let pct: CGFloat

		var body: some View {
			Text("\(Int(pct * 100)) %")
				.font(.largeTitle)
				.fontWeight(.bold)
				.foregroundColor(.white)
		}
	}
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
