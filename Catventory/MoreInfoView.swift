//
//  MoreInfoView.swift
//  Catventory
//
//  Created by Sasha Bagrov on 17/03/2024.
//

import SwiftUI

struct MoreInfoView: View {
	
	func homeScreen() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: HomeScreenView())
			window.makeKeyAndVisible()
		}
	}
	
    var body: some View {
		
		Button() {
			homeScreen()
		} label: {
			Text("Go Back")
			Image(systemName: "arrowshape.turn.up.backward")
		}
		.foregroundStyle(.white)
		.buttonStyle(.borderedProminent)
		.frame(maxWidth: .infinity, alignment: .center)
		.padding()
		
        Text("Version Beta 0.1")
		Text("Developed and made by Sasha Bagrov")
		Text("2024")
    }
}

#Preview {
    MoreInfoView()
}
