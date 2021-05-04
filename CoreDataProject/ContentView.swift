//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Brendan Keane on 2021-05-04.
//

import SwiftUI

//makes the student struct conform to hashable
struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
        // \.self can be used as long as the items that you are listing conform to hashable - so that the List can identify unique items
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
