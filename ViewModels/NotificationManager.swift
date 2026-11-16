import Foundation
import UserNotifications

// المسؤول عن إرسال وإلغاء إشعارات السقي
class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    // نسخة وحدة نستخدمها في كل التطبيق
    static let shared = NotificationManager()

    // للتجربة: true يرسل الإشعار بعد 5 ثواني، وغيريها false للاستخدام الحقيقي
    let testMode = false

    override init() {
        super.init()
        // عشان الإشعار يطلع حتى لو التطبيق مفتوح
        UNUserNotificationCenter.current().delegate = self
    }

    // يطلب إذن إرسال الإشعارات من المستخدم
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    // يجدول إشعار للنبتة حسب أيام السقي (ويلغي القديم أول)
    func schedule(for plant: Plant) {
        cancel(for: plant)
        // محتوى الإشعار
        let content = UNMutableNotificationContent()
        content.title = "Plants"
        content.body = "Hey! Let's water your \(plant.name)!"
        content.sound = .default
        // الوقت: 5 ثواني في وضع التجربة، وإلا حسب أيام السقي
        let seconds: TimeInterval = testMode ? 5 : interval(for: plant.wateringDays)
        // التكرار يشتغل بس في الوضع الحقيقي
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: !testMode)
        // رقم الإشعار هو نفس رقم النبتة عشان نقدر نلغيه بعدين
        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    // يلغي إشعار النبتة (عند الحذف أو التعديل)
    func cancel(for plant: Plant) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }

    // يحول نص أيام السقي إلى ثواني
    func interval(for days: String) -> TimeInterval {
        switch days {
        case "Every 2 days":
            return 2 * 86400
        case "Once a week":
            return 7 * 86400
        default:
            return 86400
        }
    }

    // يخلي الإشعار يظهر وهو التطبيق مفتوح
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }
}
