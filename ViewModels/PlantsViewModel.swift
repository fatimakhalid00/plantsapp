import SwiftUI
import Observation

// المسؤول عن بيانات النباتات وكل المنطق
@Observable
class PlantsViewModel {
    // كل النباتات المحفوظة
    var plants: [Plant] = []
    // هل المستخدم بدأ يضيف نباتات قبل (عشان نفرق بين الصفحة الأولى و No reminders)
    var hasStarted = false
    // هل صفحة Set Reminder مفتوحة أو لا
    var showSheet = false
    // رقم النبتة اللي نعدلها (إذا فاضي يعني نضيف نبتة جديدة)
    var editingID: UUID? = nil

    // قيم الفورم (اللي كانت State في الصفحة)
    var plantName = ""
    var room = "Bedroom"
    var light = "Full sun"
    var days = "Every day"
    var water = "20-50 ml"

    // خيارات القوائم
    let roomOptions  = ["Bedroom", "Kitchen", "Living Room"]
    let lightOptions = ["Full sun", "Partial shade", "Shade"]
    let daysOptions  = ["Every day", "Every 2 days", "Once a week"]
    let waterOptions = ["20-50 ml", "50-100 ml", "100-200 ml"]

    // هل نعدل نبتة موجودة أو نضيف جديدة
    var isEditing: Bool {
        editingID != nil
    }

    // يتأكد إن اسم النبتة مو فاضي
    var canSave: Bool {
        !plantName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // عدد النباتات اللي انسقت
    var completedCount: Int {
        plants.filter { $0.isDone }.count
    }

    // هل كل النباتات انسقت (شاشة 
    var allDone: Bool {
        !plants.isEmpty && completedCount == plants.count
    }

    // نسبة الإنجاز لشريط التقدم (من 0 إلى 1)
    var progress: Double {
        plants.isEmpty ? 0 : Double(completedCount) / Double(plants.count)
    }

    // النص اللي يطلع فوق القائمة حسب الإنجاز
    var statusText: String {
        if completedCount == 0 {
            return "Your plants are waiting for a sip 💦"
        } else {
            return "\(completedCount) of your plants feel loved today ✨"
        }
    }

    // يفتح الشيت لإضافة نبتة جديدة
    func startAdding() {
        resetForm()
        showSheet = true
    }

    // يفتح الشيت لتعديل نبتة موجودة ويعبي الفورم ببياناتها
    func startEditing(_ plant: Plant) {
        plantName = plant.name
        room = plant.room
        light = plant.light
        days = plant.wateringDays
        water = plant.waterAmount
        editingID = plant.id
        showSheet = true
    }

    // يحفظ النبتة: يعدل الموجودة أو يضيف جديدة
    func savePlant() {
        guard canSave else { return }
        if let id = editingID, let index = plants.firstIndex(where: { $0.id == id }) {
            // وضع التعديل
            plants[index].name = plantName
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDays = days
            plants[index].waterAmount = water
            // إشعار: نجدول من جديد بالبيانات المعدلة
            NotificationManager.shared.schedule(for: plants[index])
        } else {
            // وضع الإضافة
            let plant = Plant(name: plantName, room: room, light: light,
                              wateringDays: days, waterAmount: water)
            plants.append(plant)
            // إشعار: نجدول إشعار للنبتة الجديدة
            NotificationManager.shared.schedule(for: plant)
        }
        // أول ما تنحفظ نبتة نعتبر المستخدم بدأ
        hasStarted = true
        resetForm()
    }

    // يحذف النبتة اللي نعدلها (زر Delete Reminder)
    func deleteEditingPlant() {
        // إشعار: نلغي إشعار النبتة قبل الحذف
        if let plant = plants.first(where: { $0.id == editingID }) {
            NotificationManager.shared.cancel(for: plant)
        }
        plants.removeAll { $0.id == editingID }
        hasStarted = true
        resetForm()
    }

    // يحذف نبتة محددة (السحب على الصف)
    func deletePlant(_ plant: Plant) {
        // إشعار: نلغي إشعار النبتة قبل الحذف
        NotificationManager.shared.cancel(for: plant)
        plants.removeAll { $0.id == plant.id }
        hasStarted = true
    }

    // يقلب حالة النبتة بين منسقية وغير منسقية
    func toggleDone(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isDone.toggle()
        }
    }

    // يرجع قيم الفورم للوضع الأول
    func resetForm() {
        plantName = ""
        room = "Bedroom"
        light = "Full sun"
        days = "Every day"
        water = "20-50 ml"
        editingID = nil
    }
}
