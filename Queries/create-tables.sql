-- More details about the database in Rovinskyi_Pavliuk_Report.docx 
---------------------------------------
CREATE TABLE rp.`order` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`date` DATETIME NOT NULL,
	`customer_id` INT NOT NULL,
	`worker_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
CREATE TABLE rp.`customer` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(25) NOT NULL,
	`surname` varchar(35) NOT NULL,
	`phone` varchar(13) NOT NULL,
	`discount` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
CREATE TABLE rp.`worker` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(25) NOT NULL,
	`surname` varchar(35) NOT NULL,
	`position_id` INT NOT NULL,
	`hire_date` DATE NOT NULL,
	`age` INT NOT NULL,
	`manager_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
CREATE TABLE rp.`position` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`title` varchar(40) NOT NULL,
	`salary` INT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
CREATE TABLE rp.`product` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`title` varchar(40) NOT NULL,
	`description` varchar(255) NOT NULL,
	`quantity` INT NOT NULL,
	`price` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
CREATE TABLE rp.`order_detail` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`order_id` INT NOT NULL,
	`product_id` INT NOT NULL,
	`quantity` INT NOT NULL,
	PRIMARY KEY (`id`)
);
---------------------------------------
ALTER TABLE rp.`order` ADD CONSTRAINT `order_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`);

ALTER TABLE rp.`order` ADD CONSTRAINT `order_fk1` FOREIGN KEY (`worker_id`) REFERENCES `worker`(`id`);

ALTER TABLE rp.`worker` ADD CONSTRAINT `worker_fk0` FOREIGN KEY (`position_id`) REFERENCES `position`(`id`);

ALTER TABLE rp.`order_detail` ADD CONSTRAINT `order_detail_fk0` FOREIGN KEY (`order_id`) REFERENCES `order`(`id`);

ALTER TABLE rp.`order_detail` ADD CONSTRAINT `order_detail_fk1` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`);

ALTER TABLE rp.order_detail DROP FOREIGN KEY order_detail_fk1;

ALTER TABLE rp.order_detail ADD CONSTRAINT order_detail_fk1 FOREIGN KEY (product_id) REFERENCES rp.product (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE rp.order_detail DROP FOREIGN KEY order_detail_fk0;

ALTER TABLE rp.order_detail ADD CONSTRAINT order_detail_fk0 FOREIGN KEY (order_id) REFERENCES rp.order (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE rp.order DROP FOREIGN KEY order_fk0, DROP FOREIGN KEY order_fk1;

ALTER TABLE rp.order 
ADD CONSTRAINT order_fk0 FOREIGN KEY (customer_id) REFERENCES rp.customer(id) ON UPDATE CASCADE, 
ADD CONSTRAINT order_fk1 FOREIGN KEY (worker_id) REFERENCES rp.worker(id) ON UPDATE CASCADE;

ALTER TABLE rp.worker DROP FOREIGN KEY worker_fk0;

ALTER TABLE rp.worker ADD CONSTRAINT worker_fk0 FOREIGN KEY (position_id) REFERENCES rp.position (id) ON UPDATE CASCADE;