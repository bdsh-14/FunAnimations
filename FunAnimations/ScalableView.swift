//
//  ScalableView.swift
//  FunAnimations
//
//  Created by Bidisha Biswas on 4/23/23.
//

import SwiftUI

struct ScalableView: View {
	@State var offsetFactor: CGFloat // 0..1

	var animatableData: CGFloat {
		get { offsetFactor }
		set { offsetFactor = newValue }
	}

	var scaleFactor: CGFloat {
		return 0.75 * cos(offsetFactor * CGFloat.pi * 2) * 0.5
	}

    var body: some View {
        Circle()
			.scaleEffect(self.scaleFactor)
			.offset(x: offsetFactor * 20)
			.onTapGesture {
				withAnimation {
					offsetFactor = CGFloat.random(in: 0...1)
				}
			}
    }
}

struct ScalableView_Previews: PreviewProvider {
    static var previews: some View {
		ScalableView(offsetFactor: 0.5)
    }
}
