//
//  HomeScreenView.swift
//  Catventory
//
//  Created by Fluffik3666 on 17/03/2024.
//

import SwiftUI

struct HomeScreenView: View {
	@State private var isPickerShown = false
	// Define state variables for each column
	@State private var firstNames: [String] = []
	@State private var lastNames: [String] = []
	@State private var tourDates: [String] = []
	@State private var tourTimes: [String] = []
	@State private var tourNames: [String] = []
	@State var csvImported = false
	@State var csvImportedAlert = false
	@Environment(\.dismiss) private var dismiss
	
	func moreInfo() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: MoreInfoView())
			window.makeKeyAndVisible()
		}
	}
	
	func moreScans() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: ShowAllScansView())
			window.makeKeyAndVisible()
		}
	}
	
	func showImportedCSVData() {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = UIHostingController(rootView: ShowImportedCSVDataView(firstNames: firstNames, lastNames: lastNames, tourDates: tourDates, tourTimes: tourTimes, tourNames: tourNames))
			window.makeKeyAndVisible()
		}
	}
	
	func startScanning() {
		if csvImported == true {
			if let window = UIApplication.shared.windows.first {
				window.rootViewController = UIHostingController(rootView: ContentView())
				window.makeKeyAndVisible()
			}
		} else {
			csvImportedAlert = true
		}
	}
	
	
	func parseCSV(at url: URL) {
		// Reset previous data
		firstNames = []
		lastNames = []
		tourDates = []
		tourTimes = []
		tourNames = []
		
		do {
			let content = try String(contentsOf: url)
			let rows = content.split(separator: "\n")
			
			for row in rows.dropFirst() {
				let columns = row.split(separator: ",", omittingEmptySubsequences: false).map { String($0) }
				
				if columns.count >= 5 {
					firstNames.append(columns[0])
					lastNames.append(columns[1])
					tourDates.append(columns[2])
					tourTimes.append(columns[3])
					tourNames.append(columns[4])
				}
			}
		
			csvImported = true
			dismiss()
		} catch {
			Alert(
				title: Text("Error"),
				message: Text("Failed to read file! Error: \(error)"),
				dismissButton: .default(Text("OK"))
			)
			csvImported = false
			print("Failed to read the file: \(error)")
		}
	}
	
    var body: some View {
		Text("Catventory")
			.font(.largeTitle)
			.fontWeight(.bold)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
		
		VStack {
			Button() {
				isPickerShown.toggle()
			} label: {
				Text("Import CSV")
				Image(systemName: "tablecells")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
			.sheet(isPresented: $isPickerShown, onDismiss: {
				showImportedCSVData()
			}) {
				DocumentPicker { url in
					parseCSV(at: url)
				}
			}
			
			Button() {
				moreScans()
			} label: {
				Text("Show previous scans")
				Image(systemName: "qrcode.viewfinder")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
			
			Button() {
				moreInfo()
			} label: {
				Text("More Info")
				Image(systemName: "info.square")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
			
			Spacer()
			
			Button() {
				startScanning()
			} label: {
				Text("Start Scanning")
				Image(systemName: "play")
			}
			.alert(isPresented: $csvImportedAlert) {
				Alert(title: Text("CSV File not imported"), message: Text("Please import a csv file"), dismissButton: .default(Text("Got it!")))
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .bottom)
			.padding()
			
			// TODO: 	Remove this button as it is a devloper button
			Button() {
				csvImported.toggle()
			} label: {
				Text("DEBUG - Toggle var csv imported, current state \(csvImported)")
				Image(systemName: "ladybug")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .bottom)
			.padding()
		}
		
		Spacer()
    }
}


struct DocumentPicker: UIViewControllerRepresentable {
	var onDocumentSelected: (URL) -> Void
	
	func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
		let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.commaSeparatedText], asCopy: true)
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UIDocumentPickerDelegate {
		var parent: DocumentPicker
		
		init(_ documentPicker: DocumentPicker) {
			self.parent = documentPicker
		}
		
		func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
			guard let url = urls.first else { return }
			parent.onDocumentSelected(url)
		}
	}
}

#Preview {
    HomeScreenView()
}
