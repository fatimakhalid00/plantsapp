import SwiftUI

struct NoReminders: View {
    // نفس الـ ViewModel اللي تستخدمه باقي الصفحات
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // ZStack عشان زر + يطلع تحت اليمين
        ZStack(alignment: .bottomTrailing) {
            // خلفية الشاشة
            Color(.systemBackground)
                .ignoresSafeArea()
            // VStack يرتب العناصر تحت بعض
            VStack(spacing: 0) {
                // العنوان مع الخط
                PageHeader()
                Spacer()
                // نص عدم وجود تذكيرات: حجم 20 وبوزن Semibold ولون 756F6F مثل Sketch
                Text("No reminders set yet..")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color(red: 117/255, green: 111/255, blue: 111/255))
                Spacer()
            }
            // زر + يفتح صفحة Set Reminder لإضافة نبتة
            PlusButton {
                viewModel.startAdding()
            }
        }
    }
}

// عرض الصفحة في الـ Preview
#Preview {
    NoReminders(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
