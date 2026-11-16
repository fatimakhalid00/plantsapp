import SwiftUI

@main
struct MyApp: App {
    // ViewModel واحد للتطبيق كله
    @State private var viewModel = PlantsViewModel()

    var body: some Scene {
        WindowGroup {
            // ZStack: الصفحات تحت، والشيت فوقها
            ZStack {
                // نختار الصفحة حسب حالة النباتات
                if viewModel.plants.isEmpty && !viewModel.hasStarted {
                    // أول مرة: Start your plant journey
                    page1(viewModel: viewModel)
                } else if viewModel.plants.isEmpty {
                    // ما فيه نباتات بعد الإغلاق أو الحذف: No reminders
                    NoReminders(viewModel: viewModel)
                } else if viewModel.allDone {
                    // كل النباتات انسقت: All Done
                    page4(viewModel: viewModel)
                } else {
                    // فيه نباتات: Today Reminder
                    page3(viewModel: viewModel)
                }

                // الشيت: خلفية معتمة وفوقها صفحة Set Reminder
                if viewModel.showSheet {
                    // الخلفية المعتمة، الضغط عليها يسكر الشيت
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { viewModel.closeSheet() }
                        .transition(.opacity)
                    // صفحة Set Reminder تطلع من تحت
                    SetReminderView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
            }
            // حركة ظهور واختفاء الشيت
            .animation(.easeInOut(duration: 0.3), value: viewModel.showSheet)
            // نطلب إذن الإشعارات أول ما يفتح التطبيق
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
            .preferredColorScheme(.dark)
        }
    }
}
