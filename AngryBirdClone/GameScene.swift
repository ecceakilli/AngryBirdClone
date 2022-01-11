//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by ece on 7.01.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var gameStarted = false //false ise bird cekme işlemini yap,
    var originalPosition : CGPoint?
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    
    override func didMove(to view: SKView) {
        
        //PHYSICS BODY
        //ekrana sınırlar cizdim kusun düşüp yerde kalması için
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        //artık kontakları algılama opsiyonumuz var
        self.physicsWorld.contactDelegate = self
        
        //bird
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        //etkileşim içerisine alacak boyut
        bird.physicsBody = SKPhysicsBody.init(circleOfRadius: birdTexture.size().height / 12)
        //yercekiminden etkilenecek mi?
        bird.physicsBody?.affectedByGravity = false
        //fiziksel similasyonlardan etkilenecek mi?
        bird.physicsBody?.isDynamic = true
        //objeye kütle atandı
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        
        //bir kategori tanımladıgında diger taraflarla bir çatısma yasadıgında bildirim alırsın.
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        //her görünümü kategorize edecegiz.
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        //hangisi ile çarpısabilir
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        //box
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 8, height: boxTexture.size().height / 8)
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true //kutuların saga sola hareketi
        box1.physicsBody?.mass = 0.3
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true //kutuların saga sola hareketi
        box2.physicsBody?.mass = 0.3
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true //kutuların saga sola hareketi
        box3.physicsBody?.mass = 0.3
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true //kutuların saga sola hareketi
        box4.physicsBody?.mass = 0.3
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true //kutuların saga sola hareketi
        box5.physicsBody?.mass = 0.3
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //Label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 5
        self.addChild(scoreLabel)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      /*
        //kusun tıkladıgında ucmasını sagla sabit oldugu yerde
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true
       */
        if gameStarted == false {
            if let touch = touches.first {
                //kuş nerede
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                    
                }
            }
        }
      
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //kullanıcı bird cismine dokunmayı bıraktığı gibi fırlatma işlemi yapacagımız alan
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                            }
                        }
                    }
                    
                }
            }
        }
      
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //render edildikce ekran sürekli değişirken devamlı kontrol etmek için olan fonk.
        if let birdPhysicsBody = bird.physicsBody {
            //velocitiy - bird hızını kontrol eder eğer bird durdu ise oyunu sıfırla gibi
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.position = originalPosition!
                bird.zPosition = 3
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false
            }
        }
    }
    
    
}
