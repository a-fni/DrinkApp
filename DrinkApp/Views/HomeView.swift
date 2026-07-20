//
//  HomeView.swift
//  DrinkApp
//
//  Created by Andrea Ferrarini on 20/07/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // SwiftData access - will be using the next two fields for storage access
    @Environment(\.modelContext) private var modelContext
    
    // App settings and drink entries are fetched here
    @Query private var appSettings:  [AppSettings]
    @Query private var drinkEntries: [DrinkEntry]

    
    // mark: Body of the view
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(drinkEntries) { drinkEntry in
                    NavigationLink {
                        Text("Item at \(drinkEntry.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard)) value \(drinkEntry.amount)")
                    } label: {
                        Text(drinkEntry.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    
    // mark: Actions on the view
    private func addItem() {
        withAnimation {
            let newDrinkEntry = DrinkEntry(amount: 150, timestamp: Date())
            modelContext.insert(newDrinkEntry)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(drinkEntries[index])
            }
        }
    }
    
}

#Preview {
    HomeView().modelContainer(for: DrinkEntry.self, inMemory: true)
}
