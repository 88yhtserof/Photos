//
//  SampleData.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

struct SampleData: Hashable {
    let thumnailURL: String
    let albumTitle: String
    let numberOfAlbums: String
}

#if DEBUG
extension SampleData {
    static let sample = [
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2023 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2024 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2025 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2026 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2027 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2028 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2029 여름", numberOfAlbums: "403"),
        SampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2030 여름", numberOfAlbums: "403")
    ]
}

enum ImageLoader {
    
    /// Load a Image from URL and return a UIImage.
    static func loadImage(from url: URL) async throws -> UIImage {
        let (data, reponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse = reponse as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw ImageLoadError.invalidURL
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageLoadError.imageLoadFailed
        }
        return image
    }
}

enum ImageLoadError: Error {
    case invalidURL
    case imageLoadFailed
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "the URL is invalid"
        case .imageLoadFailed:
            return "Failed to load image"
        }
    }
}
#endif
