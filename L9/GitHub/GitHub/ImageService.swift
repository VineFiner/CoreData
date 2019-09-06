//
//  ImageService.swift
//  GitHub
//
//  Created by vine on 2019/9/1.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

public class ImageService {
    public static let shared = ImageService()
    private static let cacheQueue = DispatchQueue(label: "cacheQueue")

    // TODO: Build disk cache too.
    var memoryCache = NSCache<NSString, UIImage>()

    //
    public func fetchImage(imageString: String?) -> UIImage? {
        guard let poster =  imageString else {
            return nil
        }
        if let cached = memoryCache.object(forKey: poster as NSString) {
            return cached
        }
        guard let profileImageURL = URL(string: poster) else {
            return nil
        }
        URLSession.shared.dataTask(with: profileImageURL) { [weak self] (data, response, error) in
            if let imageData = data, let image = UIImage(data: imageData) {
                self?.memoryCache.setObject(image, forKey: poster as NSString)
            }
        }.resume()
        return nil
//        guard let imageData = try? Data(contentsOf: profileImageURL),let image = UIImage(data: imageData) else {
//             return nil
//        }
//        self.memoryCache.setObject(image, forKey: poster as NSString)
//        return image
    }
}
