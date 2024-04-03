//
//  ImportPreviousCSVFilesView.swift
//  Catventory
//
//  Created by Sasha Bagrov on 31/03/2024.
//
import SwiftUI

struct ImportPreviousCSVFilesView: View {
	var toursData: [String: [[String: String]]] {
		(UserDefaults.standard.dictionary(forKey: "structuredTourDataStorage") as? [String: [[String: String]]]) ?? [:]
	}
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		List(toursData.keys.sorted(), id: \.self) { tourKey in
			var data = toursData[tourKey]
			
			if let firstParticipant = toursData[tourKey]?.first,
			   let tourName = firstParticipant["Tour name"],
			   let tourDate = firstParticipant["Tour date"],
			   let tourTime = firstParticipant["Tour time"] {
				// Combine tour name, date, and time into a single text view
				VStack(alignment: .leading) {
					Text("\(tourName)")
						.bold()
						.font(.headline)
					Text("Date: \(tourDate)")
					Text("Time: \(tourTime)")
					
					Button {
						UserDefaults.standard.set(data, forKey: "sessionCSVFile")
						dismiss()
					} label: {
						HStack {
							Text("Import this CSV")
							Image(systemName: "square.and.arrow.down.on.square")
						}
					}
					.buttonStyle(.borderedProminent)
				}
			}
		}
	}
}


#Preview {
    ImportPreviousCSVFilesView()
}

