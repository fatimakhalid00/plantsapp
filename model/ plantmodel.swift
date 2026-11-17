import Foundation

// شكل النبتة
struct Plant: Identifiable {
    // رقم مميز لكل نبتة
    let id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    // كمية الماء
    var waterAmount: String
    // هل النبتة انسقت اليوم أو لا
    var isDone = false
}
