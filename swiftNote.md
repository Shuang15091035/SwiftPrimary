###程序运行中改变设备的方向
#if os(iOS ) <= 8.0
override var shouldAutorotate: Bool {
return true
}

override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
switch toInterfaceOrientation {
case .landscapeLeft, .landscapeRight:
playerLayer?.frame = self.view.bounds
case .portrait:
playerLayer?.frame = .init(x: 0, y: 20, width: self.view.frame.width, height: 200)
default: break

}
print("\(#function)")

}
override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {

}
#else
//iOS 8.0 And Later
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
if size.width > size.height {
playerLayer?.frame = .init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: size.width, height: size.height))
} else {
playerLayer?.frame = .init(x: 0, y: 20, width: size.width, height: 200)
}
}
#endif

//java env  (MacOS ManageJDK version)
http://blog.csdn.net/kmyhy/article/details/52764058



Swift

##storeProperty:
used: class, Struct,
struct:valueType
struct FixedLengthRange {
let firstValue: Int
var length: Int
}
//        value Type 不可修改
//        fixedLength.firstValue = 20
lazy storeProperty:
必须为变量 (因为在实例初始化完成后，它的初始值可能不会被检索。常量属性在初始化完成之前必须具有一个值，因此不能被声明为lazy)
property Observer（任意存储属性，子类重写父类属性）
class:referenceType
##computedProperty:
class,structures,enumeration（
they provide a getter and an optional setter to retrieve and set other properties and values indirectly.）
##typeProperty


mport UIKit

////属性的使用
//class Square {
//    //存储属性
//    var width: Double = 0.0 {
//        willSet {
//            print("will Set --\(newValue)")
//        }
//        didSet {
//           print("did Set \(oldValue)")
//        }
//    }
//
//    //计算属性
//    var girth: Double {
//        set {
//           width = girth / 4
//        }
//
//        get {
//            return width * 4
//        }
//    }
//    lazy var dog: Square = Square() //延迟存储属性,必须为变量，不能是常量
//
//    var area: Double {
//        get {
//            return girth
//        }
//        set(newArea) {
//            girth = newArea
//        }
//    }
//    //类型属性，只能是计算属性，不能使存储属性，一个类只有一个，多个实例共享一份
//    class var PI: Double {
//        return 3.14
//    }
//}
//
//var stu = Square()
//
//Square.PI
//
//stu.width = 10 //此时会调用 willSet 和didSet
//
//print(stu.width)
//
////枚举
//
//enum ServerRespondse {
//    case result(String, String)
//    case failure(String)
//}
//
//let success = ServerRespondse.result("6:00", "8:00")
//let failure = ServerRespondse.failure("Out of cheese.")
//
//switch success {
//case let .result(sunrise, sunset) :
//    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
//case let .failure(message):
//    print("Failure...  \(message)")
//}
//
//enum CompassPoint: String {
//    case north
//    case south
//    case east
//    case west
//}
//
//var directionToHead = CompassPoint.east.rawValue
////此处已经知道了directionToHead的类型
////directionToHead = .south
//
////switch directionToHead {
////case .north:
////    print("Lots of planets have a north")
////case .south:
////    print("Watch out for penguins")
////case .east:
////    print("Where the sun rises")
////case .west:
////    print("Where the sun rises")
////}
////关联值(associated Values)
//enum Barcode {
//    case upc(Int, Int, Int, Int)
//    case qrCode(String)
//}
//
//var code = Barcode.upc(8, 85909, 51226, 3)
//var qrcode = Barcode.qrCode("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
//
//switch code {
////    1.0提取关联值，最为一个常量或变量
//case .upc(let numberSystem, let manufacturer, let product, let check):
//    print("UPC: \(numberSystem) \(manufacturer) \(product) \(check)")
//case .qrCode(let productCode):
//    print("QR code: \(productCode)")
//    //2.//提取所有关联值，作为一个常量
//case let .upc(numberSystem, manufacturer, product, check):
//    print("UPC: \(numberSystem) \(manufacturer) \(product) \(check)")
//case let .qrCode(productCode):
//    print("QR code: \(productCode)")
//}
//
////Raw Value (String,characters,Int,Float)
////explicit call
//enum ASSCIIControlCharacter: Character {
//    case tab = "\t"
//    case lineFeed = "\n"
//    case carriageReturn = "\r"
//}
////implicit call
//enum Planet: Int {
//    case mercury = 1, venus, earth, mars
//}
////初始化通过原始值，获取对应枚举情况,没有返回nil
//let positionToFind = 9
//
//if let va = Planet(rawValue:positionToFind) {
//    switch va {
//    case .mercury:
//        print("Mostly harmless")
//    default:
//        print("Not a safe place for humans")
//    }
//} else {
//     print("There isn't a planet at position \(positionToFind)")
//}
////Recursive Enumerations, A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
//
//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addiction(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}
////to enable indirection for all of the enumeration’s cases that need it
////indirect enum ArithmeticExpression {
////    case number(Int)
////    case addiction(ArithmeticExpression, ArithmeticExpression)
////    case multiplication(ArithmeticExpression, ArithmeticExpression)
////}
////(5 + 4) * 2:
//let five = ArithmeticExpression.number(5)
//let four = ArithmeticExpression.number(4)
//let sum = ArithmeticExpression.addiction(five, four)
//let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//
//func evaluate(_ expression: ArithmeticExpression) -> Int {
//    switch expression {
//    case let .number(value):
//        return value
//    case let .addiction(left, right):
//        return evaluate(left) + evaluate(right)
//    case let .multiplication(left, right):
//        return evaluate(left) * evaluate(right)
//    }
//}
//
//var res = evaluate(product)
//
////
//let minutes = 60
//let minuteInterval = 15
//for tickMark in stride(from: 0, through: minutes, by: minuteInterval) {
//    print(tickMark)
//}

//switch

//tuple
let point = (1, -1)
switch point {
case let (x, y) where x == y:
print("x==y")
case let (x, y) where x == -y:
print("x==-y")
case let (x, y):
print("\(x),\(y)")
}

let somePoint = (10, 1)
//value bindings
switch somePoint {
case (0, 0):
print("\(somePoint) is at the origin")
case (_, 0):
print("\(somePoint) is on the x-axis")
case (0, _):
print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
print("\(somePoint) is inside the box")
default:
print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"

//Compound Cases
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
print("\(someCharacter) is a consonant")
default:
print("\(someCharacter) is not a vowel or a consonant")
}
//control Transfer statements

//fallthrough 贯穿整个case

//label Statement


//Early Exit
func greet(person: [String: String]){
guard let name = person["name"] else {
return
}
print("Hello \(name)!")

guard let location = person["location"] else {
print("I hop")
return
}
print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

//Checking API Availability
if #available(iOS 10, macOS 10.12, *){

} else {

}

