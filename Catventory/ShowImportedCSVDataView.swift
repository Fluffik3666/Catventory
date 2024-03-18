//
//  ShowImportedCSVDataView.swift
//  Catventory
//
//  Created by Sasha Bagrov on 17/03/2024.
//

import SwiftUI

struct ShowImportedCSVDataView: View {
	var firstNames: [String]
	var lastNames: [String]
	var tourDates: [String]
	var tourTimes: [String]
	var tourNames: [String]
	
	func homeScreen() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: HomeScreenView())
			window.makeKeyAndVisible()
		}
	}
	
	
	
    var body: some View {
		
		if firstNames.isEmpty && lastNames.isEmpty && tourDates.isEmpty && tourTimes.isEmpty && tourNames.isEmpty {
			Button() {
				homeScreen()
			} label: {
				Text("An error happened or no file was chosen. Click to go back")
				Image(systemName: "arrowshape.turn.up.backward")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .center)
			.padding()
		} else {
			List(tourNames.indices, id: \.self) { index in
				VStack(alignment: .leading) {
					Text("Name: \(firstNames[index]) \(lastNames[index])")
					Text("Tour: \(tourNames[index])")
					Text("Date: \(tourDates[index])")
					Text("Time: \(tourTimes[index])")
				}
			}
		}
	}
}

#Preview {
    ShowImportedCSVDataView(firstNames: ["Robin"], lastNames: ["Hood"], tourDates: ["03/03/03"], tourTimes: ["12:40"], tourNames: ["Shlapokclack"])
}
