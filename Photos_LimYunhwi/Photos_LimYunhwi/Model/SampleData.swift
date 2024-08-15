//
//  SampleData.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

struct GridSampleData: Hashable {
    let thumnailURL: String
    let albumTitle: String
    let numberOfAlbums: String
}

struct ListSampleData: Hashable {
    let type: MediaType
    let numberOfPhotos: Int
    
    enum MediaType: String {
        case video = "video"
        case livephoto = "livephoto"
        
        var name: String {
            self.rawValue
        }
    }
}

#if DEBUG
extension GridSampleData {
    static let gridSample = [
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2023 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2024 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2025 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2026 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2027 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2028 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2029 여름", numberOfAlbums: "403"),
        GridSampleData(thumnailURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOex3tCt52M2UxHfpybUkY4nBLCJj9WWEWQ&s", albumTitle: "2030 여름", numberOfAlbums: "403")
    ]
    
    static let listSample = [
        ListSampleData(type: .video, numberOfPhotos: 35),
        ListSampleData(type: .livephoto, numberOfPhotos: 144)
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
