# coffee

lib/
│
├── core/                       # Thành phần dùng chung (Global)
│   ├── constants.dart          # Hằng số (Colors, API keys, Supabase URL)
│   ├── supabase_client.dart    # Nơi duy nhất khởi tạo Supabase
│   ├── utils.dart              # Các hàm dùng chung (format tiền, ngày tháng)
|   └── widgets/                # Chứa các widget
│
├── features/                   # Từng cụm tính năng của app
│   ├── auth/                   # Đăng nhập / Đăng ký
│   │   ├── models/             # Định nghĩa Object (VD: UserModel)
│   │   ├── repository/         # Chứa logic gọi Supabase Auth & DB
│   │   ├── controllers/        # Quản lý State (Bloc/Provider/GetX...)
│   │   └── views/              # Chứa toàn bộ UI (Pages và Widgets)
│   │
│   ├── menu/                   # Xem thực đơn
│   │   ├── models/             
│   │   ├── repository/         
│   │   ├── controllers/        
│   │   └── views/              
│   │
│   └── orders/                 # Giỏ hàng & Lịch sử đặt hàng
│       ├── models/             
│       ├── repository/         
│       ├── controllers/        
│       └── views/              
│
└── main.dart                   # Entry point, chạy app

1. features/auth/ (Luồng Chào mừng & Xác thực)
Views bao gồm: Onboarding, Login, Register, Forgot Password.

Giải thích: Gom hết bọn này vào một cục vì chúng nó chung một mục đích: 
    Mời chào và cấp quyền cho user vào app. Khi đã đăng nhập xong thì luồng này kết thúc, user hiếm khi quay lại trừ khi đăng xuất.

2. features/menu/ (Luồng Khám phá món)
   Views bao gồm: Home, Detail Item, Favorite.

Giải thích: Hành vi của khách ở đây là xem danh sách đồ uống (Home), bấm vào xem chi tiết size/đá/đường (Detail Item) và 
    "thả tim" lưu lại món ruột (Favorite). Cả 3 màn này đều chọc chung vào bảng dữ liệu products (sản phẩm) nên gom chung là chuẩn nhất.

3. features/orders/ (Luồng Mua hàng & Vận chuyển)
   Views bao gồm: Cart (Giỏ hàng), Order (Màn hình thanh toán/Checkout), Delivery (Màn hình bản đồ theo dõi Shipper).

Giải thích: Đây là luồng tạo ra tiền. 
    Bắt đầu từ việc chốt số lượng món -> Áp mã giảm giá/chọn địa chỉ giao -> Chuyển sang trạng thái theo dõi đơn hàng.

4. features/profile/ (Luồng Cá nhân hóa)
   Views bao gồm: Profile (Trang cá nhân), Add Payment Method (Thêm phương thức thanh toán).

Giải thích: Nơi quản lý thông tin định danh (Tên, Email, Ảnh đại diện, Điểm thưởng) và các thiết lập tài chính (Thẻ Visa, Ví điện tử).

5. features/notifications/ (Luồng Thông báo)
   Views bao gồm: Notifications.

Giải thích: Màn hình này nên tách ra thành một feature riêng. 
    Vì logic của nó rất khác biệt (thường dùng để hứng dữ liệu Realtime khi shipper đổi trạng thái đơn, 
    hoặc hứng push notification khuyến mãi từ hệ thống bắn về).