//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Brendan Keane on 2021-05-04.
//

import SwiftUI
import CoreData

// updated filtered results to accept a generic NSManaged object, as well as a view
struct FilteredList<T: NSManagedObject, Content: View>: View {
    // fetch request for NSManagedObject and saves the result in the singers variable
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    enum Predicates: String {
        case beginsWithCased = "BEGINSWITH"
        case beginsWtih = "BEGINSWITH[c]"
        case containsCased = "CONTAINS"
        case contains = "CONTAINS[c]"
        case equals = "=="
        case equalsCased = "==[c]"
        case lessThan = "<"
        case greaterThan = ">"
    }
    
    // this is our content closure; we'll call this once fot each item in the list
    let content: (T) -> Content
    // this creates a list of our content closure from our fetched results 
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    // retreives the initial values that are drawn from using values that are passed in from content view
    //@ViewBuilder lets our containing view send in multiple views and our list will creat implicit HStack, just like a regular list
    //@escaping says the closure will be stored away and used later, which means swift needs to take care of its memory
    init(predicate: Predicates, filterKey: String, filterValue: String, predicateStyle: String, sortArray: [NSSortDescriptor],   @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortArray, predicate: NSPredicate(format:"%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

