//
//  ViewController.swift
//  AR Videos
//
//  Created by DreamAR on 13/08/19.
//  Copyright © 2019 DreamAR. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            configuration.trackingImages = trackingImages
            configuration.maximumNumberOfTrackedImages = 3
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
//        let videoURL: URL
//        let videoPlayer: AVPlayer
        
        if let imageAnchor = anchor as? ARImageAnchor{
            let size = imageAnchor.referenceImage.physicalSize
            
            let plane = SCNPlane(width: size.width, height: size.height)
            var callbuttonNode = SCNNode()
            var fbbuttonNode = SCNNode()
            var mssgbuttonNode = SCNNode()
            var borderframeNode = SCNNode()
            
            let callbuttonScene = SCNScene(named: "art.scnassets/call.scn")
            let fbbuttonScene = SCNScene(named: "art.scnassets/facebook.scn")
            let mssgbuttonScene = SCNScene(named: "art.scnassets/mssg.scn")
            let borderframeScene = SCNScene(named: "art.scnassets/Border.scn")
            
            callbuttonNode = callbuttonScene!.rootNode
            fbbuttonNode = fbbuttonScene!.rootNode
            mssgbuttonNode = mssgbuttonScene!.rootNode
            borderframeNode = borderframeScene!.rootNode
            
            if imageAnchor.referenceImage.name == "test_image_1"{
                let videoURL_1 = Bundle.main.url(forResource: "test_video_1", withExtension: "mp4")!
                let videoPlayer_1 = AVPlayer(url: videoURL_1)
                plane.firstMaterial?.diffuse.contents = videoPlayer_1
                videoPlayer_1.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer_1.currentItem, queue: nil) { (notification) in
                    videoPlayer_1.seek(to: CMTime.zero)
                    videoPlayer_1.play()
                    print("Looping Video")
                }
            }else if imageAnchor.referenceImage.name == "test_image_2"{
                let videoURL_2 = Bundle.main.url(forResource: "test_video_2", withExtension: "mp4")!
                let videoPlayer_2 = AVPlayer(url: videoURL_2)
                plane.firstMaterial?.diffuse.contents = videoPlayer_2
                videoPlayer_2.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer_2.currentItem, queue: nil) { (notification) in
                    videoPlayer_2.seek(to: CMTime.zero)
                    videoPlayer_2.play()
                    print("Looping Video")
                }

            }else if imageAnchor.referenceImage.name == "test_image_3"{
                let videoURL_3 = Bundle.main.url(forResource: "test_video_3", withExtension: "mp4")!
                let videoPlayer_3 = AVPlayer(url: videoURL_3)
                plane.firstMaterial?.diffuse.contents = videoPlayer_3
                videoPlayer_3 .play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer_3.currentItem, queue: nil) { (notification) in
                    videoPlayer_3.seek(to: CMTime.zero)
                    videoPlayer_3.play()
                    print("Looping Video")
                }
            }
            
            
            
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            callbuttonNode.position = SCNVector3(size.width/1.67, size.height/3, 0)
            fbbuttonNode.position = SCNVector3(size.width/1.67, size.height/(-3), 0)
            mssgbuttonNode.position = SCNVector3(size.width/1.67, 0, 0)
            borderframeNode.scale = SCNVector3(size.width*1.85, size.height*1.25, 1);
            borderframeNode.position = SCNVector3(0,-0.0013,-0.0025)
            planeNode.addChildNode(callbuttonNode)
            planeNode.addChildNode(fbbuttonNode)
            planeNode.addChildNode(mssgbuttonNode)
            planeNode.addChildNode(borderframeNode)
            node.addChildNode(planeNode)
        }
        return node
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let tappedView = sender.view as! SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty{
            let result = hitTest.first!
            let name = result.node.parent?.name
//            let geometry = result.node.geometry
            if name == "Call"{
                UIApplication.shared.open(URL(string: "tel://1111111111")!, options: [:], completionHandler: nil)
                print("call is pressed")
            }else if name == "Message"{
                if let url = URL(string: "https://www.gmail.com"){
                    UIApplication.shared.open(url)
                }
                print("Message is pressed")
            }else if name == "Facebook"{
                if let url = URL(string: "https://www.facebook.com"){
                    UIApplication.shared.open(url)
                }
            }
        }
        
    }
}
