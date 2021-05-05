//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Brendan Keane on 2021-05-04.
//

import CoreData
import SwiftUI

//makes the student struct conform to hashable
struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Singer.entity(), sortDescriptors: []) var singer: FetchedResults<Singer>
    
    @State private var lastNameFilter = "A"
    let sortArray: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true), NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)]
    
    let predicateStyle = "BEGINSWITH"
    
    var body: some View {
        FilteredList(predicate: .containsCased, filterKey: "lastName", filterValue: lastNameFilter, predicateStyle: predicateStyle, sortArray: sortArray) { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
        
        Button("Add Examples") {
            let taylor = Singer(context: self.moc)
            taylor.firstName = "Taylor"
            taylor.lastName = "Swift"
            
            let ed = Singer(context: self.moc)
            ed.firstName = "Ed"
            ed.lastName = "Sheeran"
            
            let adele = Singer(context: self.moc)
            adele.firstName = "Adele"
            adele.lastName = "Adkins"
            
            try? self.moc.save()
        }
        
        Button("Show A") {
            self.lastNameFilter = "A"
        }
        
        Button("Show S") {
            self.lastNameFilter = "S"
        }
    }
        /*
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id:\.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "Kit Kat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
        }
    }
    */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
