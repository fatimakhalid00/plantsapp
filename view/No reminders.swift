import SwiftUI

struct page4: View {
    // نفس الـ ViewModel اللي تستخدمه باقي الصفحات
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // ZStack عشان زر + يطلع فوق الصفحة تحت اليمين
        ZStack(alignment: .bottomTrailing) {
            // خلفية الشاشة (سوداء مع الدارك مود)
            Color(.systemBackground)
                .ignoresSafeArea()
// هذا النص اللي بالنص
            Text("No reminders set yet..")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

// VStack يرتب العناصر تحت بعض
            VStack(spacing: 0) {
                // عنوان الصفحة
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

// الخط الرمادي تحت العنوان
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal)

    // يدفع العنوان لفوق
                Spacer()
            }

// زر + الدائري تحت اليمين
            Button {
// يفتح صفحة Set Reminder لإضافة نبتة جديدة
                viewModel.startAdding()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.plantGreen, in: Circle())
            }
// مسافة الزر من حافة الشاشة
            .padding(24)
        }
    }
}


#Preview {
    page4(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
