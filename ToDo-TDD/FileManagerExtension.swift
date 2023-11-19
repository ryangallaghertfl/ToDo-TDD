//
//  FileManagerExtension.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 19/11/2023.
//

import Foundation

extension FileManager {
    
    func documentsURL(name: String) -> URL {
        guard let documentsURL = urls(for:.documentDirectory, in: .userDomainMask).first 
        else {
            fatalError()
        }
        return documentsURL.appendingPathComponent(name)
    }
}
