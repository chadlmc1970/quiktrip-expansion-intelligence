-- QuikTrip Store Seed Data (Sample - 50 stores for POC)
-- In production, this would contain all 1,000+ stores

SET search_path TO quiktrip, public;

-- Oklahoma/Kansas (QuikTrip origin states) - 15 stores
INSERT INTO stores (store_id, store_name, address, city, state, zip_code, latitude, longitude, store_type, square_footage, fuel_pumps, opened_date, population_5mi, median_income_5mi, avg_daily_traffic, status) VALUES
('QT001', 'QuikTrip #1 - Tulsa Central', '3 N Boston Ave', 'Tulsa', 'OK', '74103', 36.1540, -95.9928, 'urban', 3500, 12, '2015-03-15', 125000, 52000, 18000, 'active'),
('QT002', 'QuikTrip #2 - Tulsa Brookside', '3506 S Peoria Ave', 'Tulsa', 'OK', '74105', 36.1240, -95.9740, 'suburban', 4000, 14, '2016-06-20', 98000, 68000, 22000, 'active'),
('QT003', 'QuikTrip #3 - Tulsa Cherry Street', '1524 E 15th St', 'Tulsa', 'OK', '74120', 36.1420, -95.9620, 'urban', 3200, 10, '2017-04-10', 110000, 61000, 16000, 'active'),
('QT004', 'QuikTrip #4 - Oklahoma City', '6400 N May Ave', 'Oklahoma City', 'OK', '73116', 35.5450, -97.5650, 'suburban', 4500, 16, '2014-08-25', 145000, 58000, 24000, 'active'),
('QT005', 'QuikTrip #5 - Wichita East', '1330 N Rock Rd', 'Wichita', 'KS', '67206', 37.6980, -97.2530, 'suburban', 4200, 14, '2016-11-12', 92000, 62000, 19000, 'active'),
('QT006', 'QuikTrip #6 - Wichita West', '8282 W 21st St N', 'Wichita', 'KS', '67205', 37.7340, -97.4520, 'highway', 4800, 20, '2015-09-18', 78000, 71000, 32000, 'active'),
('QT007', 'QuikTrip #7 - Tulsa I-44 & Yale', '4545 S Yale Ave', 'Tulsa', 'OK', '74135', 36.1050, -95.8970, 'highway', 5000, 18, '2018-02-14', 88000, 75000, 35000, 'active'),
('QT008', 'QuikTrip #8 - Tulsa BA Expressway', '7878 E 71st St', 'Tulsa', 'OK', '74133', 36.0540, -95.9050, 'suburban', 4300, 16, '2017-07-22', 102000, 82000, 26000, 'active'),
('QT009', 'QuikTrip #9 - Norman', '1234 W Main St', 'Norman', 'OK', '73069', 35.2200, -97.4480, 'suburban', 3900, 14, '2019-01-30', 86000, 54000, 20000, 'active'),
('QT010', 'QuikTrip #10 - Broken Arrow', '2020 S Elm Pl', 'Broken Arrow', 'OK', '74012', 36.0250, -95.7910, 'suburban', 4100, 15, '2018-10-05', 94000, 73000, 21000, 'active'),
('QT011', 'QuikTrip #11 - Edmond', '15501 N Pennsylvania Ave', 'Edmond', 'OK', '73013', 35.6880, -97.5030, 'suburban', 4200, 14, '2017-12-08', 88000, 81000, 23000, 'active'),
('QT012', 'QuikTrip #12 - Stillwater', '2424 W 6th Ave', 'Stillwater', 'OK', '74074', 36.1260, -97.0820, 'suburban', 3800, 12, '2016-05-15', 52000, 45000, 15000, 'active'),
('QT013', 'QuikTrip #13 - Owasso', '12345 E 96th St N', 'Owasso', 'OK', '74055', 36.2950, -95.8480, 'suburban', 4000, 14, '2019-08-12', 76000, 72000, 19000, 'active'),
('QT014', 'QuikTrip #14 - Overland Park', '12300 W 95th St', 'Overland Park', 'KS', '66215', 38.9640, -94.7180, 'suburban', 4400, 16, '2018-04-20', 112000, 89000, 25000, 'active'),
('QT015', 'QuikTrip #15 - Shawnee', '16000 Midland Dr', 'Shawnee', 'KS', '66217', 39.0150, -94.8200, 'suburban', 3900, 13, '2017-11-03', 68000, 71000, 18000, 'active'),

-- Georgia/South Carolina - 10 stores
('QT016', 'QuikTrip #16 - Atlanta Buckhead', '3637 Peachtree Rd NE', 'Atlanta', 'GA', '30319', 33.8490, -84.3640, 'urban', 4200, 16, '2018-06-22', 115000, 78000, 28000, 'active'),
('QT017', 'QuikTrip #17 - Atlanta Midtown', '1000 Peachtree St NE', 'Atlanta', 'GA', '30309', 33.7780, -84.3850, 'urban', 3800, 12, '2019-03-15', 128000, 65000, 22000, 'active'),
('QT018', 'QuikTrip #18 - Marietta', '2500 Cobb Pkwy SE', 'Marietta', 'GA', '30060', 33.9440, -84.5160, 'suburban', 4500, 16, '2017-09-08', 95000, 72000, 26000, 'active'),
('QT019', 'QuikTrip #19 - Athens', '355 N Milledge Ave', 'Athens', 'GA', '30601', 33.9570, -83.3730, 'urban', 3600, 12, '2018-11-20', 82000, 48000, 17000, 'active'),
('QT020', 'QuikTrip #20 - Savannah', '7804 Abercorn St', 'Savannah', 'GA', '31406', 32.0120, -81.1350, 'suburban', 4100, 14, '2019-05-14', 76000, 58000, 19000, 'active'),
('QT021', 'QuikTrip #21 - Columbia SC', '7500 Two Notch Rd', 'Columbia', 'SC', '29223', 34.0470, -80.9590, 'suburban', 4300, 15, '2018-02-28', 88000, 54000, 21000, 'active'),
('QT022', 'QuikTrip #22 - Charleston', '1950 Sam Rittenberg Blvd', 'Charleston', 'SC', '29407', 32.7890, -79.9870, 'suburban', 4000, 14, '2019-07-19', 92000, 68000, 23000, 'active'),
('QT023', 'QuikTrip #23 - Greenville SC', '1245 Woodruff Rd', 'Greenville', 'SC', '29607', 34.8290, -82.3570, 'suburban', 4200, 15, '2018-09-25', 86000, 64000, 20000, 'active'),
('QT024', 'QuikTrip #24 - Augusta', '3450 Washington Rd', 'Augusta', 'GA', '30907', 33.4660, -82.0830, 'suburban', 4100, 14, '2017-12-12', 79000, 52000, 18000, 'active'),
('QT025', 'QuikTrip #25 - Macon', '4750 Riverside Dr', 'Macon', 'GA', '31210', 32.8060, -83.6900, 'highway', 4600, 18, '2019-04-08', 72000, 49000, 29000, 'active'),

-- Arizona - 10 stores
('QT026', 'QuikTrip #26 - Phoenix Downtown', '1 E Washington St', 'Phoenix', 'AZ', '85004', 33.4480, -112.0740, 'urban', 3500, 12, '2016-03-20', 135000, 58000, 25000, 'active'),
('QT027', 'QuikTrip #27 - Scottsdale', '7014 E Camelback Rd', 'Scottsdale', 'AZ', '85251', 33.5020, -111.9260, 'suburban', 4400, 16, '2017-08-15', 105000, 92000, 27000, 'active'),
('QT028', 'QuikTrip #28 - Tempe', '1255 E Apache Blvd', 'Tempe', 'AZ', '85281', 33.4150, -111.9090, 'urban', 3700, 12, '2018-01-12', 118000, 54000, 21000, 'active'),
('QT029', 'QuikTrip #29 - Mesa', '1950 S Stapley Dr', 'Mesa', 'AZ', '85204', 33.3830, -111.8080, 'suburban', 4200, 14, '2017-05-22', 96000, 62000, 22000, 'active'),
('QT030', 'QuikTrip #30 - Glendale', '7300 W Bell Rd', 'Glendale', 'AZ', '85308', 33.6390, -112.2280, 'suburban', 4300, 15, '2018-10-30', 88000, 65000, 24000, 'active'),
('QT031', 'QuikTrip #31 - Chandler', '3000 W Chandler Blvd', 'Chandler', 'AZ', '85226', 33.3060, -111.8860, 'suburban', 4500, 16, '2019-02-18', 102000, 78000, 26000, 'active'),
('QT032', 'QuikTrip #32 - Gilbert', '1150 S Val Vista Dr', 'Gilbert', 'AZ', '85296', 33.3360, -111.7510, 'suburban', 4100, 14, '2018-07-25', 94000, 82000, 23000, 'active'),
('QT033', 'QuikTrip #33 - Peoria AZ', '8350 W Peoria Ave', 'Peoria', 'AZ', '85345', 33.5810, -112.2410, 'suburban', 4000, 14, '2017-11-15', 78000, 71000, 20000, 'active'),
('QT034', 'QuikTrip #34 - Surprise', '13765 W Grand Ave', 'Surprise', 'AZ', '85374', 33.6310, -112.3670, 'suburban', 4200, 15, '2019-06-10', 84000, 68000, 22000, 'active'),
('QT035', 'QuikTrip #35 - Phoenix I-10', '4242 S 48th St', 'Phoenix', 'AZ', '85040', 33.4030, -112.0140, 'highway', 4800, 20, '2016-12-08', 92000, 55000, 34000, 'active'),

-- Texas - 10 stores
('QT036', 'QuikTrip #36 - Dallas Downtown', '1201 Main St', 'Dallas', 'TX', '75202', 32.7810, -96.7970, 'urban', 3600, 12, '2017-04-18', 142000, 62000, 26000, 'active'),
('QT037', 'QuikTrip #37 - Fort Worth', '1800 University Dr', 'Fort Worth', 'TX', '76107', 32.7250, -97.3700, 'suburban', 4200, 14, '2018-08-22', 108000, 68000, 24000, 'active'),
('QT038', 'QuikTrip #38 - Arlington', '1155 N Collins St', 'Arlington', 'TX', '76011', 32.7490, -97.0930, 'suburban', 4400, 16, '2019-01-15', 115000, 65000, 27000, 'active'),
('QT039', 'QuikTrip #39 - Plano', '3901 W Parker Rd', 'Plano', 'TX', '75023', 33.0410, -96.7870, 'suburban', 4300, 15, '2017-10-20', 102000, 95000, 25000, 'active'),
('QT040', 'QuikTrip #40 - Frisco', '2500 Preston Rd', 'Frisco', 'TX', '75034', 33.1280, -96.8040, 'suburban', 4500, 16, '2018-12-10', 96000, 105000, 28000, 'active'),
('QT041', 'QuikTrip #41 - Irving', '3550 W Airport Fwy', 'Irving', 'TX', '75062', 32.8410, -96.9820, 'highway', 4700, 18, '2017-06-28', 88000, 58000, 31000, 'active'),
('QT042', 'QuikTrip #42 - Garland', '660 W Kingsley Rd', 'Garland', 'TX', '75040', 32.9280, -96.6500, 'suburban', 4100, 14, '2019-03-22', 92000, 61000, 22000, 'active'),
('QT043', 'QuikTrip #43 - Richardson', '1400 E Campbell Rd', 'Richardson', 'TX', '75081', 32.9740, -96.6830, 'suburban', 4000, 14, '2018-05-17', 98000, 78000, 23000, 'active'),
('QT044', 'QuikTrip #44 - McKinney', '8200 State Hwy 121', 'McKinney', 'TX', '75070', 33.1870, -96.6560, 'suburban', 4300, 15, '2019-09-12', 86000, 88000, 24000, 'active'),
('QT045', 'QuikTrip #45 - Denton', '2630 W University Dr', 'Denton', 'TX', '76201', 33.2150, -97.1580, 'urban', 3800, 12, '2018-02-08', 79000, 52000, 19000, 'active'),

-- Mixed expansion states - 5 stores
('QT046', 'QuikTrip #46 - Des Moines', '4500 Fleur Dr', 'Des Moines', 'IA', '50321', 41.5570, -93.6540, 'suburban', 4200, 14, '2019-07-25', 82000, 61000, 21000, 'active'),
('QT047', 'QuikTrip #47 - Omaha', '7272 Dodge St', 'Omaha', 'NE', '68114', 41.2610, -96.0320, 'suburban', 4100, 14, '2018-11-18', 88000, 65000, 22000, 'active'),
('QT048', 'QuikTrip #48 - St Louis', '1515 S Kingshighway Blvd', 'St Louis', 'MO', '63110', 38.6190, -90.2590, 'urban', 3600, 11, '2017-09-20', 112000, 48000, 18000, 'active'),
('QT049', 'QuikTrip #49 - Springfield MO', '3030 S Glenstone Ave', 'Springfield', 'MO', '65804', 37.1830, -93.2860, 'suburban', 4000, 13, '2019-04-15', 76000, 51000, 19000, 'active'),
('QT050', 'QuikTrip #50 - Kansas City', '8800 State Ave', 'Kansas City', 'KS', '66112', 39.1150, -94.7690, 'highway', 4600, 18, '2018-06-30', 94000, 56000, 30000, 'active');
