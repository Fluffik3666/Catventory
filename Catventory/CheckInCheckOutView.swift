//
//  CheckInCheckOutView.swift
//  Catventory
//
//  Created by Fluffik3666 on 16/03/2024.
//

import SwiftUI

struct CheckInCheckOutView: View {
	var mode = UserDefaults.standard.object(forKey: "mode")
	
    var body: some View {
        Text("\(mode)")
    }
}

#Preview {
    CheckInCheckOutView()
}
