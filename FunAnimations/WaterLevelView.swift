import SwiftUI

struct WaterLevelView: View {

	var waterLevel: CGFloat = 0.7 // 0..1
							// let waveOffset: CGFloat // radians

	var body: some View {
		TimelineView(.animation (minimumInterval: 0.02)) { timeline in
			Canvas { context, size in
				let timeInterval = timeline.date.timeIntervalSince1970/2
				let path = WaterLevelShape(waterLevel: self.waterLevel,
										   waveOffset: timeInterval)
					.path(in: CGRect(origin: .zero, size: size))

				context.fill(path, with: .color(Color.blue.opacity(0.5)))
				context.stroke(path, with: .color(.blue), style: .init(lineWidth: 2))
			}
		}
	}
}

struct WaterLevelView_Previews: PreviewProvider {
    static var previews: some View {
        WaterLevelView()
    }
}
