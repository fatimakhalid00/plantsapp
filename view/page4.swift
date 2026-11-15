import SwiftUI

struct page5: View {
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
                // صورة النبتة
                Image("plant 2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 145)
                // العنوان تحت الصورة
                Text("All Done! 🎉")
                    // حجم العنوان تحت الصورة
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.primary)
                    .padding(.top, 30)
                // النص الصغير
                Text("All Reminders Completed")
                    // حجم النص الصغير
                    .font(.system(size: 12))
                    .foregroundStyle(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .padding(.top, 10)
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
    page5(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
