//
//  NoopFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 28/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class NoopFilter: Filter {
    
    public static let INSTANCE:Filter = NoopFilter()
    
    public func apply(rgbaImage: RGBAImage) -> RGBAImage {
        return rgbaImage.clone()
    }
}