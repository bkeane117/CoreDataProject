//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Brendan Keane on 2021-05-04.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    // we can add computed properties to our core data class in order to access optional variables more safely and conveniently
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }

}

extension Movie : Identifiable {

}
