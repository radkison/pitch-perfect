//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Robert Adkison on 3/15/15.
//  Copyright (c) 2015 Robert Adkison. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //create global audio player variable
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create instance of audio player
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        //enable the ability to use the rate property
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
    }
    
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        //stop player before playing
        audioPlayer.stop()
        //set the rate to a slow rate
        audioPlayer.rate = 0.5
        //reset to the begining of the audio
        audioPlayer.currentTime = 0.0
        //play
        audioPlayer.play()
    }

    
    @IBAction func playFastAudio(sender: UIButton) {
        
        //stop player before playing
        audioPlayer.stop()
        //set the rate to a slow rate
        audioPlayer.rate = 1.5
        //reset to the begining of the audio
        audioPlayer.currentTime = 0.0
        //play
        audioPlayer.play()
        
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        //stop  audio player
        audioPlayer.stop()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
