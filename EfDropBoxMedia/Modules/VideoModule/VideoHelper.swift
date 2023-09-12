//
//  VideoHelper.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import Foundation

class VideoHelper {
    
    init() {}
    
    func trimName(_ str: String?) -> String {
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
    
    func getUrlForVideo(path: String) -> URL? {
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        let destURL = directoryURL?.appendingPathComponent(path)
        return destURL
    }
}
