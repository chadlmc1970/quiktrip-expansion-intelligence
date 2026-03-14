-- QuikTrip Candidate Sites Seed Data

SET search_path TO quiktrip, public;

-- Strategic expansion targets in new markets
INSERT INTO candidate_sites (candidate_id, site_name, address, city, state, zip_code, latitude, longitude, proposed_type, estimated_square_footage, proposed_fuel_pumps, population_5mi, median_income_5mi, avg_daily_traffic, land_cost, construction_cost, status) VALUES
('CAND001', 'Nashville I-40 & Charlotte', 'I-40 Exit 221', 'Nashville', 'TN', '37209', 36.1627, -86.8050, 'highway', 4500, 20, 145000, 68000, 28000, 850000, 2100000, 'evaluation'),
('CAND002', 'Denver Tech Center', '8300 E Belleview Ave', 'Denver', 'CO', '80111', 39.5807, -104.8943, 'suburban', 4000, 16, 112000, 95000, 19000, 1200000, 2300000, 'evaluation'),
('CAND003', 'Charlotte University Area', '9000 University City Blvd', 'Charlotte', 'NC', '28213', 35.3070, -80.7310, 'suburban', 4200, 15, 125000, 72000, 23000, 950000, 2150000, 'evaluation'),
('CAND004', 'Tampa Brandon', '2020 W Brandon Blvd', 'Brandon', 'FL', '33511', 27.9380, -82.3180, 'suburban', 4300, 16, 135000, 66000, 26000, 800000, 2000000, 'evaluation'),
('CAND005', 'Nashville Green Hills', '3900 Hillsboro Pike', 'Nashville', 'TN', '37215', 36.1070, -86.8150, 'urban', 3800, 12, 118000, 82000, 22000, 1100000, 2200000, 'evaluation'),
('CAND006', 'Memphis Germantown', '7760 Poplar Ave', 'Germantown', 'TN', '38138', 35.0870, -89.7920, 'suburban', 4100, 14, 92000, 95000, 21000, 900000, 2100000, 'evaluation'),
('CAND007', 'Denver Aurora', '15200 E Mississippi Ave', 'Aurora', 'CO', '80012', 39.6950, -104.8010, 'suburban', 4200, 15, 105000, 68000, 24000, 850000, 1950000, 'evaluation'),
('CAND008', 'Charlotte South Blvd', '5500 South Blvd', 'Charlotte', 'NC', '28217', 35.1670, -80.8670, 'highway', 4600, 18, 128000, 62000, 30000, 750000, 2050000, 'evaluation'),
('CAND009', 'Tampa Westchase', '11110 Countryway Blvd', 'Tampa', 'FL', '33626', 28.0570, -82.6180, 'suburban', 4000, 14, 98000, 88000, 20000, 1050000, 2150000, 'evaluation'),
('CAND010', 'Nashville Brentwood', '5050 Carothers Pkwy', 'Brentwood', 'TN', '37027', 36.0120, -86.7870, 'suburban', 4400, 16, 88000, 115000, 25000, 1300000, 2400000, 'evaluation'),
('CAND011', 'Fort Myers Colonial Blvd', '12500 Colonial Blvd', 'Fort Myers', 'FL', '33966', 26.5820, -81.8580, 'suburban', 4100, 14, 112000, 58000, 22000, 700000, 1900000, 'evaluation'),
('CAND012', 'Raleigh North Hills', '4421 Six Forks Rd', 'Raleigh', 'NC', '27609', 35.8320, -78.6180, 'urban', 3700, 12, 125000, 78000, 21000, 1150000, 2250000, 'evaluation'),
('CAND013', 'Colorado Springs Powers', '5775 Constitution Ave', 'Colorado Springs', 'CO', '80915', 38.8350, -104.7280, 'suburban', 4300, 15, 95000, 72000, 23000, 650000, 1850000, 'evaluation'),
('CAND014', 'Jacksonville Beach Blvd', '13131 Beach Blvd', 'Jacksonville', 'FL', '32246', 30.2980, -81.5200, 'suburban', 4200, 15, 108000, 68000, 24000, 800000, 2000000, 'evaluation'),
('CAND015', 'Nashville Murfreesboro Pike', '4242 Murfreesboro Pike', 'Nashville', 'TN', '37217', 36.1070, -86.7270, 'highway', 4700, 19, 115000, 54000, 31000, 700000, 1950000, 'evaluation'),
('CAND016', 'Denver Highlands Ranch', '9505 S University Blvd', 'Highlands Ranch', 'CO', '80126', 39.5670, -104.8870, 'suburban', 4100, 14, 88000, 105000, 22000, 1100000, 2200000, 'evaluation'),
('CAND017', 'Greenville NC', '3030 S Evans St', 'Greenville', 'NC', '27834', 35.5890, -77.3680, 'suburban', 3900, 13, 78000, 48000, 18000, 550000, 1750000, 'evaluation'),
('CAND018', 'Lakeland Florida Ave', '5500 Florida Ave S', 'Lakeland', 'FL', '33813', 28.0040, -81.9560, 'suburban', 4000, 14, 92000, 52000, 20000, 650000, 1850000, 'evaluation'),
('CAND019', 'Knoxville Kingston Pike', '7700 Kingston Pike', 'Knoxville', 'TN', '37919', 35.9370, -84.0000, 'suburban', 4100, 14, 102000, 64000, 21000, 750000, 1950000, 'evaluation'),
('CAND020', 'Boulder Colorado', '2727 Iris Ave', 'Boulder', 'CO', '80304', 40.0240, -105.2820, 'urban', 3500, 11, 96000, 98000, 17000, 1400000, 2350000, 'evaluation');
