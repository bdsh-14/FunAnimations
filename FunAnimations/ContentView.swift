//
//  ContentView.swift
//  FunAnimations
//
//  Created by Bidisha Biswas on 4/23/23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			List {
				NavigationLink {
					ParticleView()
				} label: {
					Text("Confetti")
				}
				NavigationLink {
					EmptyView()
				} label: {
					Text("Confetti")
				}
				NavigationLink {
					EmptyView()
				} label: {
					Text("Confetti")
				}
			}
			.navigationTitle("Animation Styles")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
