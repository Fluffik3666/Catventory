//
//  SavedTourManager.swift
//  Catventory
//
//  Created by Sasha Bagrov on 01/04/2024.
//

import Foundation

struct TourDataStorage {
	static func initializeStructuredDataStorage() {
		let defaults = UserDefaults.standard
		if defaults.object(forKey: "structuredTourDataStorage") == nil {
			defaults.set([String: [[String: String]]](), forKey: "structuredTourDataStorage")
		}
	}

	static func appendData(da: [[String: String]]) {
		let defaults = UserDefaults.standard
		var currentData = defaults.object(forKey: "structuredTourDataStorage") as? [String: [[String: String]]] ?? [String: [[String: String]]]()
			
		for dictionary in da {
			if let tourName = dictionary["Tour name"] {
				if currentData[tourName] == nil {
					currentData[tourName] = [dictionary]
				} else {
					currentData[tourName]?.append(dictionary)
				}
			}
		}
			
		defaults.set(currentData, forKey: "structuredTourDataStorage")
	}

	static func getStructuredData(forTourName tourName: String? = nil) -> [String: [[String: String]]] {
		let defaults = UserDefaults.standard
		let storedData = defaults.object(forKey: "structuredTourDataStorage") as? [String: [[String: String]]] ?? [String: [[String: String]]]()
			
		if let tourName = tourName {
			return [tourName: storedData[tourName, default: [[String: String]]()]]
		} else {
			return storedData
		}
	}
}

