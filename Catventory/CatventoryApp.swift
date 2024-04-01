//
//  CatventoryApp.swift
//  Catventory
//
//  Created by Fluffik3666 on 16/03/2024.
//

import SwiftUI
import Foundation

@main
struct CatVentoryApp: App {
	init() {
		let recievers: [String: String] = [
			"1": "f673b3b7-84ae-4310-9226-930b5e098b25",
			"2": "53d24577-43dc-46b6-bdeb-72ec835127e5",
			"3": "86ca2471-eb03-41a4-9d6a-b746940d93d4",
			"4": "096416ab-91ec-493e-88c9-e975ca4b072c",
			"5": "42eb080b-2195-4ec9-82b0-ed8232925fd8",
			"6": "6193052a-c823-416e-a2dd-ed60ffd626e0",
			"7": "aa47c88c-70e5-4103-b735-c6de5afd3eb2",
			"8": "a6c87c5c-ad1e-4a8c-bebc-90d19d772d98",
			"9": "9bb7cb75-3a26-4740-93bd-bd82e00b4150",
			"10": "260024c0-8240-42d4-a4af-efa006694078",
			"11": "7da5e8c6-d46b-4974-baad-e035cd5812b2",
			"12": "1462efa4-b864-4f30-8c6d-0980e10b7303",
			"13": "6a658dfc-bbf5-4e5a-8f89-ad5eb3eb0c74",
			"14": "c02d3e3e-5a2a-411a-b906-60eca269bc12",
			"15": "fd383ddd-d301-4c8a-865a-32de5a926fe4",
			"16": "6ff08cae-b523-4fb4-b48a-e195dd8d2d81",
			"17": "1c61218e-1bc5-44bb-b924-7426d9e47520",
			"18": "905f19d8-ef8e-41da-a486-fc0b8eec1e7d",
			"19": "7f055700-4ba6-42d2-a152-57d26d1618b4",
			"20": "9f304350-1962-4688-b79e-eba3cb587f5c"
		]

		// Store the dictionary in UserDefaults
		UserDefaults.standard.set(recievers, forKey: "recievers")
		
		UserDefaults.standard.set(false, forKey: "CheckInCheckOutSheetOpen")
		
		UserDefaults.standard.set([[String: String]](), forKey: "sessionCSVFile")
		
		TourDataStorage.initializeStructuredDataStorage()
	}

	var body: some Scene {
		WindowGroup {
			HomeScreenView()
		}
	}
}
