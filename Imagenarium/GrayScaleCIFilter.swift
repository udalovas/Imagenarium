//
//  GrayScaleCIFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 13/10/2016.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation
import CoreImage

public class GrayScaleCIFilter: CIFilter {
    
    private var kernel: CIKernel?
    var inputImage:CIImage?
    
    let callback: CIKernelROICallback = {
        (index, rect) in
        return rect.insetBy(dx: -1, dy: -1)
    }
    
    public override init() {
        super.init()
        self.kernel = createKernel()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)!
        self.kernel = createKernel()
    }

    override public var outputImage: CIImage! {
        guard let inputImage = inputImage else {
            return nil
        }
        return kernel!.apply(withExtent: inputImage.extent, roiCallback: callback, arguments: [inputImage])
    }
    
    private func createKernel() -> CIColorKernel {
        let kernelString =
//            "kernel vec4 chromaKey( __sample s) { \n" +
//                "  float gray = (s.r + s.g + s.b) / 3;\n" +
//                "  return vec4( s.r, s.g, s.b, s.a ); \n" +
//            "}"
            "kernel vec4 chromaKey( __sample s) { \n" +
                "  float gray = (s.r + s.g + s.b) / 3.0;\n" +
                "  return vec4( gray, gray, gray, s.a ); \n" +
            "}"
        return CIColorKernel(string: kernelString)!
    }
}

