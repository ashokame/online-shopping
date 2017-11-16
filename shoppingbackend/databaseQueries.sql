CREATE TABLE category (
	id INT,
	name VARCHAR(50),
	description VARCHAR(255),
	image_url VARCHAR(50),
	is_active INT,
	CONSTRAINT pk_category_id PRIMARY KEY (id) 
);

CREATE TABLE user_detail (
	id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	role VARCHAR(50),
	enabled INT,
	password VARCHAR(60),
	email VARCHAR(100),
	contact_number VARCHAR(15),	
	CONSTRAINT pk_user_id PRIMARY KEY(id)
);


CREATE TABLE product (
	id INT,
	code VARCHAR(20),
	name VARCHAR(50),
	brand VARCHAR(50),
	description VARCHAR(255),
	unit_price DECIMAL(10,2),
	quantity INT,
	is_active INT,
	category_id INT,
	supplier_id INT,
	purchases INT DEFAULT 0,
	views INT DEFAULT 0,
	CONSTRAINT pk_product_id PRIMARY KEY (id),
 	CONSTRAINT fk_product_category_id FOREIGN KEY (category_id) REFERENCES category (id),
	CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES user_detail(id)	
);	






-- the address table to store the user billing and shipping addresses
CREATE TABLE address (
	id INT,
	user_id int,
	address_line_one VARCHAR(100),
	address_line_two VARCHAR(100),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(10),
	is_billing INT,
	is_shipping INT,
	CONSTRAINT fk_address_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_address_id PRIMARY KEY (id)
);

-- the cart table to store the user cart top-level details
CREATE TABLE cart (
	id INT,
	user_id int,
	grand_total DECIMAL(10,2),
	cart_lines int,
	CONSTRAINT fk_cart_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_cart_id PRIMARY KEY (id)
);
-- the cart line table to store the cart details

CREATE TABLE cart_line (
	id INT,
	cart_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	is_available INT,
	CONSTRAINT fk_cartline_product_id FOREIGN KEY (product_id ) REFERENCES product (id),
	CONSTRAINT pk_cartline_id PRIMARY KEY (id)
);


-- the order detail table to store the order

CREATE TABLE order_detail (
	id INT,
	user_id int,
	order_total DECIMAL(10,2),
	order_count int,
	shipping_id int,
	billing_id int,
	order_date date,
	CONSTRAINT fk_order_detail_user_id FOREIGN KEY (user_id) REFERENCES user_detail (id),
	CONSTRAINT fk_order_detail_shipping_id FOREIGN KEY (shipping_id) REFERENCES address (id),
	CONSTRAINT fk_order_detail_billing_id FOREIGN KEY (billing_id) REFERENCES address (id),
	CONSTRAINT pk_order_detail_id PRIMARY KEY (id)
);

-- the order item table to store order items

CREATE TABLE order_item (
	id INT,
	order_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	CONSTRAINT fk_order_item_product_id FOREIGN KEY (product_id) REFERENCES product (id),
	CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES order_detail (id),
	CONSTRAINT pk_order_item_id PRIMARY KEY (id)
);


-- adding three categories
INSERT INTO category (ID,name, description,image_url,is_active) VALUES (1,'Laptop', 'This is description for Laptop category!', 'CAT_1.png', 1);
INSERT INTO category (ID,name, description,image_url,is_active) VALUES (2,'Television', 'This is description for Television category!', 'CAT_2.png', 1);
INSERT INTO category (ID,name, description,image_url,is_active) VALUES (3,'Mobile', 'This is description for Mobile category!', 'CAT_3.png', 1);
-- adding three users 
INSERT INTO user_detail 
(ID,first_name, last_name, role, enabled, password, email, contact_number) 
VALUES (1,'Ashok', 'ME', 'ADMIN', 1, '$2a$06$ORtBskA2g5Wg0HDgRE5ZsOQNDHUZSdpJqJ2.PGXv0mKyEvLnKP7SW', 'ashoka@gmail.com', '8888888888');
INSERT INTO user_detail 
(ID,first_name, last_name, role, enabled, password, email, contact_number) 
VALUES (2,'Ravindra', 'Jadeja', 'SUPPLIER', 1, '$2a$06$bzYMivkRjSxTK2LPD8W4te6jjJa795OwJR1Of5n95myFsu3hgUnm6', 'rj@gmail.com', '9999999999');
INSERT INTO user_detail 
(ID,first_name, last_name, role, enabled, password, email, contact_number) 
VALUES (3,'Ravichandra', 'Ashwin', 'SUPPLIER', 1, '$2a$06$i1dLNlXj2uY.UBIb9kUcAOxCigGHUZRKBtpRlmNtL5xtgD6bcVNOK', 'ra@gmail.com', '7777777777');
INSERT INTO user_detail 
(ID,first_name, last_name, role, enabled, password, email, contact_number) 
VALUES (4,'Ashok', 'ME', 'USER', 1, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'ashok@gmail.com', '7777777777');

-- adding five products
INSERT INTO product (ID,code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES (1,'PRDABC123DEFX', 'iPhone 5s', 'apple', 'This is one of the best phone available in the market right now!', 18000, 5, 1, 3, 2, 0, 0 );
INSERT INTO product (ID,code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES (2,'PRDDEF123DEFX', 'Samsung s7', 'samsung', 'A smart phone by samsung!', 32000, 2, 1, 3, 3, 0, 0 );
INSERT INTO product (ID,code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES (3,'PRDPQR123WGTX', 'Google Pixel', 'google', 'This is one of the best android smart phone available in the market right now!', 57000, 5, 1, 3, 2, 0, 0 );
INSERT INTO product (ID,code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES (4,'PRDMNO123PQRX', ' Macbook Pro', 'apple', 'This is one of the best laptops available in the market right now!', 54000, 3, 1, 1, 2, 0, 0 );
INSERT INTO product (ID,code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES (5,'PRDABCXYZDEFX', 'Dell Latitude E6510', 'dell', 'This is one of the best laptop series from dell that can be used!', 48000, 5, 1, 1, 3, 0, 0 );





-- adding a supplier correspondece address
INSERT INTO address(ID,user_id, address_line_one, address_line_two, city, state, country, postal_code, is_billing, is_shipping) 
VALUES (1,4, '110 Bangalore', 'Bangalore', 'Bangalore', 'Karnataka', 'India', '560100', 1, 0 );
-- adding a cart for testing 
INSERT INTO cart (ID,user_id, grand_total, cart_lines) VALUES (1,4, 0, 0);

CREATE SEQUENCE hibernate_sequence
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;