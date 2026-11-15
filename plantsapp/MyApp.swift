import SwiftUI

@main
struct MyApp: App {
    // ViewModel واحد للتطبيق كله
    @State private var viewModel = PlantsViewModel()

    var body: some Scene {
        WindowGroup {
            // ZStack ثابت، والصفحات تتبدل داخله والشيت متعلق فيه هو
            ZStack {
                // نختار الصفحة حسب حالة النباتات
                if viewModel.plants.isEmpty && !viewModel.hasStarted {
                    // أول مرة: Start your plant journey
                    page1(viewModel: viewModel)
                } else if viewModel.plants.isEmpty {
                    // ما فيه نباتات بعد الإغلاق أو الحذف: No reminders
                    page4(viewModel: viewModel)
                } else if viewModel.allDone {
                    // كل النباتات انسقت: All Done
                    page5(viewModel: viewModel)
                } else {
                    // فيه نباتات: Today Reminder
                    page3(viewModel: viewModel)
                }
            }
            // صفحة Set Reminder تطلع كـ Sheet فوق أي صفحة
            .sheet(isPresented: $viewModel.showSheet) {
                SetReminderView(viewModel: viewModel)
            }
            // نطلب إذن الإشعارات أول ما يفتح التطبيق
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
            .preferredColorScheme(.dark)
        }
    }
}
