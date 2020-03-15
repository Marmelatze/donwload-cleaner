//
//  main.swift
//  download-cleaner
//
//  Created by Florian Pfitzer on 14.03.20.
//  Copyright © 2020 Florian Pfitzer. All rights reserved.
//

import Foundation

// Get the document directory url
let documentsUrl =  FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

do {
    // Get the directory contents urls (including subfolders urls)
    let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
    let currentDate = Date()
    var diff = DateComponents()
    diff.day = -7
    let deletePastDate = Calendar.current.date(byAdding: diff, to: currentDate)
    for url in directoryContents {
        if (url.lastPathComponent.starts(with: ".")) {
            continue
        }
        let attr = try FileManager.default.attributesOfItem(atPath: url.path)
        let modificationDate = attr[FileAttributeKey.modificationDate] as? Date
        if (modificationDate ?? currentDate < deletePastDate!) {
            print("removing " + url.path)
            
            try FileManager.default.removeItem(at: url)
        }
    }


} catch {
    print(error)
}
