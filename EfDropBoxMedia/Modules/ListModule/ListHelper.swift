//
//  ListHelper.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import UIKit

class ListHelper {
    
    init() {}
    
    func newWidthImage(_ image: UIImage, myViewHeight: CGFloat) -> CGFloat {
        
        let myImageWidth = image.size.width
        let myImageHeight = image.size.height
 
        let ratio = myViewHeight/myImageHeight
        let scaledWidth = myImageWidth * ratio
        let screenWidth = UIScreen.main.bounds.width - 32
        
        return scaledWidth < screenWidth ? scaledWidth : screenWidth
    }
    
    func getImage(name: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(name)
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    func removeEnding(_ str: String?) -> String {
        var editStr = str ?? ""
        if let dotRange = editStr.range(of: ".") {
            editStr.removeSubrange(dotRange.lowerBound..<editStr.endIndex)
        }
        return editStr
    }
    
    func getUrlForVideo(path: String?) -> URL? {
        guard let path = path else { return nil }
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        let destURL = directoryURL?.appendingPathComponent(path)
        return destURL
    }
    
    func defineContent(str: String?) -> ListType {
        guard let str = str else { return .notSupported }
        let ending = trimToPoint(str: str)
        if ["jpeg", "png", "webp"].contains(ending) { return .photo }
        else if ["MOV", "mov", "mp4"].contains(ending) { return .video }
        else { return .notSupported }
    }
    
    private func trimToPoint(str: String) -> String {
        if let range = str.range(of: ".") {
            return  String(str[range.upperBound...])
        } else {
            return ""
        }
    }
}
