//
//  PhotoHelper.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import UIKit

class PhotoHelper {
    
    init() {}
    
    func getImage(path: String?) -> UIImage? {
        guard let path = path else { return nil }
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(path)
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    func removeEnding(_ str: String?) -> String {
        guard let str = str else {return ""}
        var trim = str.replacingOccurrences(of: "/", with: "")
        if let dotRange = trim.range(of: ".") {
            trim.removeSubrange(dotRange.lowerBound..<trim.endIndex)
        }
        return trim
    }
    
    func convertToMB(size: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
}
