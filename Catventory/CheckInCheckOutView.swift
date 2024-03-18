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
	@State var peformAction = false
	private let recievers: [String: String] = UserDefaults.standard.object(forKey: "recievers") as? [String: String] ?? [:]
	var QRtextresult: String

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
			window.rootViewController = UIHostingController(rootView: ContentView())
			window.makeKeyAndVisible()
		}
	}
	
	
    var body: some View {
		var key = findKey(forValue: QRtextresult)
		 
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
			
			
			
		}
    }
}

#Preview {
    CheckInCheckOutView(QRtextresult: "42eb080b-2195-4ec9-82b0-ed8232925fd8")
}
