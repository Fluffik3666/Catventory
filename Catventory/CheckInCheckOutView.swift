//
//  CheckInCheckOutView.swift
//  Catventory
//
//  Created by Fluffik3666 on 16/03/2024.
//

import SwiftUI
import Foundation

struct CheckInCheckOutView: View {
	var mode = UserDefaults.standard.object(forKey: "mode")
	@State var parsedCSV: [Dictionary<String, String>]
	@State var peformAction = false
	private let recievers: [String: String] = UserDefaults.standard.object(forKey: "recievers") as? [String: String] ?? [:]
	var QRtextresult: String
	@State var selectedPerson = ""

	func findKey(forValue value: String) -> String? {
		for (key, val) in recievers {
			if val == value {
				return key
			}
		}
		return nil
	}
	
	
	func goHome() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: ContentView(parsedCSV: parsedCSV))
			window.makeKeyAndVisible()
		}
	}
	
	func printCSV(csv givenCsv:[Dictionary<String, String>]) -> Bool {
		print(givenCsv)
		print("e")
		print(UserDefaults.standard.object(forKey: "savedParsedCSVFiles") as Any)
		return false
	}
	
	private func updateSelectedPersonMode() {
		if let index = parsedCSV.firstIndex(where: { "\($0["First Name"] ?? "") \($0["Last Name"] ?? "")" == selectedPerson }) {
			// Get the current date and time
			let now = Date()

			// Create two instances of DateFormatter
			let dateFormatter = DateFormatter()
			let timeFormatter = DateFormatter()

			// Set the date format
			dateFormatter.dateFormat = "yyyy-MM-dd"
			// Set the time format
			timeFormatter.dateFormat = "HH:mm:ss"

			// Convert date and time to strings
			let dateString = dateFormatter.string(from: now)
			let timeString = timeFormatter.string(from: now)
			parsedCSV[index]["\(mode ?? "Check In")"] = "true"
			parsedCSV[index]["Date on \(mode ?? "Check In")"] = dateString
			parsedCSV[index]["Time on \(mode ?? "Check In")"] = timeString
				// Just for debugging purpose:
			print(parsedCSV)
		}
	}
	
	
    var body: some View {
		var key = findKey(forValue: QRtextresult)
		var csvResultTest = printCSV(csv: parsedCSV)
		 
		if key == nil {
			Button("Go Back", role: .cancel) {
				goHome()
			}
				.foregroundStyle(.white)
				.buttonStyle(.borderedProminent)
				.padding()
			
			Text("A QR code was scanned which cannot be decoded or is not a reciver QR code.")
				.bold()
				.padding()
				.background(.black)
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
		} else {
			
			Text("QR Code scanned")
				.font(.largeTitle)
				.fontWeight(.bold)
				.frame(maxWidth: .infinity, alignment: .center)
				.padding()
			
			Text("Reciever \(key ?? "1") was found")
				.bold()
				.padding()
				.background(.black)
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 20))
			
			Text("Select a user below to attach to the reciever:")
				.padding()
				.bold()
			
			
			Picker("Choose a person", selection: $selectedPerson) {
				ForEach(parsedCSV.indices, id: \.self) { index in
					Text("\(parsedCSV[index]["First Name"] ?? "Unknown") \(parsedCSV[index]["Last Name"] ?? "Unknown")")
						.tag("\(parsedCSV[index]["First Name"] ?? "") \(parsedCSV[index]["Last Name"] ?? "")")
				}
			}
			.pickerStyle(.wheel)
			.background(RoundedRectangle(cornerRadius: 15).stroke(Color.orange))
			.padding()
			
			
			Button {
				updateSelectedPersonMode()
				goHome()
			} label: {
				Text("Confirm selection")
				Image(systemName: "checkmark.seal")
			}
			.buttonStyle(.borderedProminent)
			
		}
    }
}

#Preview {
	CheckInCheckOutView(parsedCSV: [["First Name": "Joey", "Last Name": "Bloggs"], ["First Name": "Timmy", "Last Name": "Blogovich"]], QRtextresult: "1c61218e-1bc5-44bb-b924-7426d9e47520")
}
