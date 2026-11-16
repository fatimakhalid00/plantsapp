import SwiftUI

// صفحة All Done: تطلع لما كل النباتات تنسقي
struct page4: View {
    // الصفحة تاخذ البيانات من الـ ViewModel
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // الزر + فوق المحتوى في الزاوية تحت اليمين
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // العنوان والخط اللي تحته
                PageHeader()

                // الدائرة الغامقة وفوقها صورة النبتة
                ZStack {
                    // الدائرة الغامقة اللي ورا النبتة
                    Ellipse()
                        .fill(Color(red: 20/255, green: 20/255, blue: 26/255).opacity(0.58))
                        .frame(width: 205, height: 212)
                    // صورة النبتة بدون قص مع ظل خفيف
                    Image("plant 2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 153, height: 187)
                        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                        // النبتة مزاحة شوي لليمين مثل Sketch
                        .offset(x: 6)
                }
                // المسافة بين الخط تحت العنوان والدائرة مثل Sketch
                .padding(.top, 120)

                // العنوان الكبير
                Text("All Done! 🎉")
                    // حجم الخط مثل Sketch
                    .font(.system(size: 25, weight: .regular))
                    .foregroundStyle(Color.white)
                    // المسافة بين الدائرة والعنوان
                    .padding(.top, 31)

                // النص الصغير تحت العنوان
                Text("All Reminders Completed")
                    // حجم الخط مثل Sketch
                    .font(.system(size: 16, weight: .regular))
                    // لون النص الرمادي 9F9F91
                    .foregroundStyle(Color(red: 159/255, green: 159/255, blue: 145/255))
                    // المسافة بين العنوان والنص الصغير
                    .padding(.top, 11)

                // يخلي كل شي فوق
                Spacer()
            }

            // زر + يفتح شيت إضافة نبتة جديدة
            PlusButton {
                viewModel.startAdding()
            }
        }
        // خلفية الصفحة تتبع الدارك مود
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

// عرض الصفحة في الـ Preview بدون نباتات
#Preview {
    page4(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
