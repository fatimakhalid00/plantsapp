import Foundation

// شكل النبتة الواحدة (بيانات فقط، بدون أي واجهة)
struct Plant: Identifiable {
    // رقم مميز لكل نبتة
    let id = UUID()
    // اسم النبتة
    var name: String
    // الغرفة
    var room: String
    // الإضاءة
    var light: String
    // كل كم يوم تنسقى
    var wateringDays: String
    // كمية الماء
    var waterAmount: String
    // هل النبتة انسقت اليوم أو لا
    var isDone = false
}
