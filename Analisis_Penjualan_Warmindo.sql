-- 1. berapa total customer di warmindo ?
SELECT COUNT(DISTINCT customer_id) AS Total_Customer
FROM warmindo_data;

-- 2. berapa total transaksi penjualan produk di warmindo ?
SELECT COUNT(*) AS Total_Transaksi
FROM warmindo_data;

-- 3. berapa rata-rata penjualan produk di warmindo ?
SELECT ROUND(AVG(nilai_penjualan), 2) AS Rerata_Penjualan
FROM warmindo_data;

-- 4. berapakah total produk yang terjual di warmindo
SELECT SUM(quantity) AS Total_Produk_Terjual
FROM warmindo_data;

-- 5. berapa jumlah total penjualan seluruh produk ?
SELECT SUM(nilai_penjualan) AS Total_Penjualan
FROM warmindo_data;

-- 6. berapa total dari penjualan tiap produk per bulannya ?
SELECT nama_produk, 
	   EXTRACT(MONTH FROM tanggal_transaksi) AS bulan,
	   SUM(nilai_penjualan) as total_penjualan
FROM warmindo_data
GROUP BY nama_produk, bulan
ORDER BY nama_produk, bulan, total_penjualan asc;

-- 7. Apa jenis pembayaran yang sering digunakan berdasarkan jenis pesanan yang dilakukan ?
SELECT jenis_pembayaran, 
	   jenis_pesanan, 
	   COUNT(jenis_pembayaran) AS total_pengguna
FROM warmindo_data
GROUP BY jenis_pembayaran, 
		 jenis_pesanan
ORDER BY COUNT(jenis_pembayaran) desc;

-- 8. berapa banyak jumlah kuantitas produk yang terjual dengan jenis produknya
SELECT jenis_produk, 
	   SUM(quantity) AS total_kuantitas
FROM warmindo_data
GROUP BY jenis_produk
ORDER BY SUM(quantity) desc;

-- 9. Apa kategori penjualan produk untuk setiap penjualan yang terjadi ?
WITH kategori AS (
SELECT nama_produk, 
	   SUM(nilai_penjualan) AS total_penjualan
from warmindo_data
group by nama_produk 
)

SELECT nama_produk,
       total_penjualan,
       CASE WHEN total_penjualan >= 600000 THEN 'Tinggi'
	    	WHEN total_penjualan >= 400000 THEN 'Sedang'
	    	ELSE 'Rendah' END AS kategori_penjualan
FROM kategori
GROUP BY nama_produk, 
		 total_penjualan
ORDER BY total_penjualan desc;

-- 10. Bagaimana Hubungan Antara Total Customer, Rerata Penjualan, dan Total Transaksi Berdasarkan Jenis Pembayaran dan Jenis Pesanan
SELECT jenis_pembayaran, 
	   jenis_pesanan, 
	   COUNT(DISTINCT customer_id) AS total_customer, 
	   ROUND(AVG(nilai_penjualan), 2) AS rerata_penjualan, 
	   COUNT(*) AS total_transaksi
FROM warmindo_data
GROUP BY jenis_pembayaran, 
		 jenis_pesanan
order by jenis_pembayaran asc , 
		 COUNT(distinct customer_id) desc, 
		 rerata_penjualan desc; 

-- 11. Distribusi Total Transaksi Berdasarkan Nama Produk dan Jenis Pesanan
SELECT nama_produk,
	   jenis_pesanan,
	   COUNT(*) AS total_transaksi
FROM warmindo_data
GROUP BY nama_produk, 
		 jenis_pesanan
ORDER BY nama_produk, 
		 COUNT(*) desc;

