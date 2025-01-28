# Online Bookstore Database
An online bookstore that sells books to customers. The bookstore has multiple book categories and number of customers who can place orders.

## Entity Relationship Model
To model this system using ER Model must first identify the entities, attributes, and relationships that are involved.

### Entities and Attributes

1. **Genre**: Represents an individual genre of books in the bookstore.
    *Attributes*: id (PK), name, and description.

2. **Book**: Represents an individual book record in the bookstore. Contains attributes.
    *Attributes*: id (PK), title, description, author, ISBN, stock_quantity, and price.

3. **Book Genre**: Represents the many-to-many relationship between books and genres.
    *Attributes*: id (PK), bookId (FK), and genreId (FK).

4. **Customer**: Represents an individual customer record who has registered with the bookstore.
    *Attributes*: id (PK), name, date of birth, sex, phone number, address, and email.

5. **Order**: Represents an individual order record placed by a customer.
    *Attributes*: id (PK), order date, total price, and customerId (FK).

6. **Order Item**: Represents the many-to-many relationship between orders and books.
    *Attributes*: id (PK), bookId (FK), and orderId (FK), unit_price, and quantity.

### Relationships

1. **Many-to-Many**
    - One book can belong to multiple genres.
    - One order can contain multiple books

2. **One-to-Many**
    - One genre can have multiple books.
    - One customer can place multiple orders.

## Entity Relationship Diagram (ERD)

## The SQL Database Schema

```sql
-- Genres Table
CREATE TABLE genres (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL
);

-- Books Table
CREATE TABLE books (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT DEFAULT NULL,
    author VARCHAR(100) NOT NULL,
    published_year YEAR(4) NOT NULL,
    ISBN VARCHAR(100) NOT NULL UNIQUE,
    stock_quantity INT NOT NULL DEFAULT 0,
    price DOUBLE(11, 2) NOT NULL CHECK(price > 0)
);

-- Book Genres Tables
CREATE TABLE books_genres (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bookId INT NOT NULL,
    genreId INT NOT NULL,
    FOREIGN KEY bookId REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY genreId REFERENCES genres(id) ON DELETE CASCADE
);

-- Customers Table
CREATE TABLE customers (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    birth_date DATE DEFAULT NULL,
    sex ENUM("F", "M"),
    address VARCHAR(100) DEFAULT NULL
);

-- Orders Table
CREATE TABLE orders (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customerId INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- total_price DOUBLE(11, 2) NOT NULL,
    FOREIGN KEY customerId REFERENCES customers(id) ON DELETE CASCADE

-- Order Items Table
CREATE TABLE order_items (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bookId INT NOT NULL,
    orderId INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    unit_price DOUBLE(11, 2) NOT NULL,
    FOREIGN KEY customerId REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY orderId REFERENCES orders(id) ON DELETE CASCADE
);
```
    
