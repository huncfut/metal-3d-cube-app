//
//  ViewController.swift
//  metal-3d-cube-app
//
//  Created by Kuba Zeligowski on 21.12.2017.
//  Copyright © 2017 Kuba Zeligowski. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {
    
    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    var vertexBuffer: MTLBuffer!
    var pipelineState: MTLRenderPipelineState!
    let vertexData:[Float] = [0.0, 1.0, 0.0,
                              -1.0, -1.0, 0.0,
                              1.0, -1.0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        device = MTLCreateSystemDefaultDevice()
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.framebufferOnly = true
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: [])
        let defaultLibrary = device.makeDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

