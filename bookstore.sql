-- Author Table
CREATE TABLE authors (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Publisher Table
CREATE TABLE publishers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- Books Table
CREATE TABLE books (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL,
    author_id INT NOT NULL,
    publisher_id INT NOT NULL,
    published_year YEAR(4) NOT NULL,
    ISBN VARCHAR(100) NOT NULL UNIQUE,
    stock_quantity INT NOT NULL DEFAULT 0,
    price DOUBLE(11, 2) NOT NULL CHECK(price > 0),
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES publishers(id) ON DELETE CASCADE
);

-- Genres Table
CREATE TABLE genres (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL
);

-- Book Genre Tables
CREATE TABLE genre_book (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- Customers Table
CREATE TABLE customers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    birth_date DATE DEFAULT NULL,
    sex ENUM("female", "male"),
    address VARCHAR(100) DEFAULT NULL
);

-- Orders Table
CREATE TABLE orders (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    status ENUM("pending", "shipped", "delivered", "cancelled", "paid"),
    date_place DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DOUBLE(11, 2) NOT NULL,
    shipping_address VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Order Items Table
CREATE TABLE order_item (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    order_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    unit_price DOUBLE(11, 2) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE payments (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    date_paid DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM("mobile transfer","cash", "paypal") DEFAULT "cash",
    amount_paid DOUBLE(11, 2) NOT NULL,
    status ENUM("pending", "successful", "failed", "cancelled", "refunded"),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
