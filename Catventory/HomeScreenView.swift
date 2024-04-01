//
//  HomeScreenView.swift
//  Catventory
//
//  Created by Fluffik3666 on 17/03/2024.
//

import SwiftUI
import SwiftCSV


struct HomeScreenView: View {
	@State private var isPickerShown = false
	@State var importedCSVparsed: [Dictionary<String, String>] = []
	@State var csvImported = false
	@State var csvImportedAlert = false
	@Environment(\.dismiss) private var dismiss
	@State private var text = ""
	@State private var isImporting = false
	@State private var error: Error?
	@State var importPreviousCSVFilesSheet = false
	
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
	
	func setSessionCSVfile(Items: [[String: String]]) {
		let defaults = UserDefaults.standard
		defaults.set(Items, forKey: "sessionCSVFile")
	}
	
	
	func parseCSV(at url: URL) -> Result<[Dictionary<String, String>], Error>{
		let accessing = url.startAccessingSecurityScopedResource()
		defer {
		  if accessing {
			url.stopAccessingSecurityScopedResource()
		  }
		}
		
		//return Result { try String(contentsOf: url) }
		
		do {
			let content = try String(contentsOf: url)
			let csv: CSV = try CSV<Named>(string: content)
			var returnCSVRows: [Dictionary<String, String>] = []
			
			try csv.enumerateAsDict { dict in
				print("dict hss been enum to dict")
				returnCSVRows.append(dict)
			}
			
			
			csvImported = true
			dismiss()
			TourDataStorage.appendData(da: returnCSVRows)
			return .success(returnCSVRows)
		} catch {
			csvImported = false
			print("Failed to read the file: \(error)")
			return .failure(error)
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
				isPickerShown = true
			} label: {
				Text("Import CSV")
				Image(systemName: "tablecells")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
			.fileImporter(
				isPresented: $isPickerShown,
				allowedContentTypes: [.text, .plainText, .commaSeparatedText]
			) { result in
				switch result {
				case .success(let file):
					let tempOutput = parseCSV(at: file)
					switch tempOutput {
					case .success(let parsedData):
						importedCSVparsed = parsedData
						setSessionCSVfile(Items: importedCSVparsed)
						csvImported = true
					case .failure(let parseError):
						print(parseError.localizedDescription)
					}
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
			
			
			Button() {
				importPreviousCSVFilesSheet = true
			} label: {
				Text("Import previous CSV files")
				Image(systemName: "square.and.arrow.down")
			}
			.foregroundStyle(.white)
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			.padding()
			.sheet(isPresented: $importPreviousCSVFilesSheet) {
				ImportPreviousCSVFilesView()
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
			
			// TODO: Remove this button as it is a devloper button
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
			
			
			//TODO: Remove this button as it is a developer button
			
			Button() {
				UserDefaults.standard.set([], forKey: "structuredTourDataStorage")
			} label: {
				Text("DEBUG - clear saved csv files")
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

#Preview {
    HomeScreenView()
}
