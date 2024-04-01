//
//  ImportPreviousCSVFilesView.swift
//  Catventory
//
//  Created by Sasha Bagrov on 31/03/2024.
//

import SwiftUI

struct Tour: Identifiable {
	let id = UUID()
	var name: String
	var date: String
	var time: String
}


struct ImportPreviousCSVFilesView: View {
	var savedParsedCSVFiles = UserDefaults.standard.object(forKey: "savedParsedCSVFiles") as? [[String: String]]
	
	func fetchTours() -> [Tour] {
		let structuredData = TourDataStorage.getStructuredData()
		var tours: [Tour] = []

		for (tourName, details) in structuredData {
			details.forEach { detail in
				if let date = detail["Tour date"], let time = detail["Tour time"] {
					let tour = Tour(name: tourName, date: date, time: time)
					tours.append(tour)
				}
			}
		}
			
		return tours
	}

    var body: some View {
		var tours: [Tour] = fetchTours()
		List(tours) { tour in
			VStack(alignment: .leading) {
				Text(tour.name)
					.font(.headline)
				Text("Date: \(tour.date), Time: \(tour.time)")
					.font(.subheadline)
			}
		}
    }
}

#Preview {
    ImportPreviousCSVFilesView()
}
