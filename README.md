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