//
//  ListHelper.swift
//  EfDropBoxMedia
//
//  Created by user on 10.09.2023.
//

import UIKit

class ListHelper {
    
    init() {}
    
    func aspectRatio(_ image: UIImage, myViewHeight: CGFloat) -> CGFloat {
        
        let myImageWidth = image.size.width
        let myImageHeight = image.size.height
 
        let ratio = myViewHeight/myImageHeight
        let scaledWidth = myImageWidth * ratio
        let screenWidth = UIScreen.main.bounds.width - 32
        
        return scaledWidth < screenWidth ? scaledWidth : screenWidth
    }
    
    func getImage(name: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
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
}
