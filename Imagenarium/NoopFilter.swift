//
//  NoopFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 28/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

open class NoopFilter: Filter {
    
    open static let INSTANCE:Filter = NoopFilter()
    
    open func apply(_ rgbaImage: RGBAImage) -> RGBAImage {
        return rgbaImage.clone()
    }
}
