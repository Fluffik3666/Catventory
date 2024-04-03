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
	
	static func addTour(tourName: String, participants: [[String: String]]) {
		let defaults = UserDefaults.standard
		
		// Attempt to retrieve the existing tours dictionary
		var tours = defaults.dictionary(forKey: "structuredTourDataStorage") as? [String: [[String: String]]] ?? [:]
		
		// Check if the tour already exists
		if tours[tourName] != nil {
			print("\(tourName) already exists. Consider adding participants to the existing tour.")
		} else {
			// Add the new tour with its participants
			tours[tourName] = participants
			
			// Save the updated tours dictionary back to UserDefaults
			defaults.set(tours, forKey: "structuredTourDataStorage")
		}
	}
}

