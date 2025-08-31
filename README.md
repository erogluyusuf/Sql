# Sql
# MySQL 8.0 Anahtar Kelimeleri: Kullanım Koşulları ve Örnekleri (A-Z)

Bu doküman, MySQL 8.0'daki anahtar kelimeleri, ayrılmış olup olmadıklarını, kullanım koşullarını ve pratik kullanım örneklerini içermektedir.

## A

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `ACCESSIBLE` | Evet | Sorgu iyileştirici için bir ipucudur; kullanılacak bir dizini belirtir. Ayrılmış kelimedir. | `SELECT * FROM magaza ACCESSIBLE INDEX (idx_urun);` |
| `ACCOUNT` | Hayır | `CREATE/ALTER USER` komutlarında hesap özelliklerini (örn: kilitleme) yönetir. | `ALTER USER 'user'@'host' ACCOUNT LOCK;` |
| `ACTION` | Hayır | Yabancı anahtar kısıtlamalarında (`ON DELETE`/`ON UPDATE`) ne yapılacağını belirtir. | `FOREIGN KEY (id) REFERENCES t(id) ON DELETE NO ACTION;` |
| `ACTIVE` | Hayır | Group Replication gibi özelliklerde bir üyenin durumunu belirtir. | `... MEMBER_STATE = 'ONLINE' AND MEMBER_ROLE = 'PRIMARY'` |
| `ADD` | Evet | `ALTER TABLE` ile tabloya sütun, dizin veya kısıtlama ekler. Ayrılmış kelimedir. | `ALTER TABLE urunler ADD COLUMN fiyat DECIMAL(10, 2);` |
| `ADMIN` | Hayır | Belirli sistem değişkenlerini ayarlamak için gereken yetkiyi ifade eder. | `SET PERSIST innodb_buffer_pool_size = 1G WITH ADMIN;` |
| `AFTER` | Hayır | `ALTER TABLE`'da yeni sütunun hangi sütundan sonra ekleneceğini belirtir. | `ALTER TABLE kullanicilar ADD adres VARCHAR(255) AFTER soyad;` |
| `AGAINST` | Hayır | `FULLTEXT` aramalarda `MATCH()` fonksiyonu içinde arama ifadesini belirtir. | `SELECT * FROM makaleler WHERE MATCH(baslik) AGAINST('veritabanı');` |
| `ALL` | Evet | Genellikle `UNION ALL` ile yinelenen satırları dahil etmek veya alt sorgularda kullanılır. Ayrılmış kelimedir. | `SELECT sehir FROM saticilar UNION ALL SELECT sehir FROM musteriler;` |
| `ALTER` | Evet | Veritabanı nesnelerinin (tablo, veritabanı, kullanıcı) yapısını değiştiren DDL komutudur. Ayrılmış kelimedir. | `ALTER TABLE musteriler RENAME TO yeni_musteriler;` |
| `ANALYZE` | Evet | Tablo dizin istatistiklerini güncelleyerek sorgu performansını iyileştirir. Ayrılmış kelimedir. | `ANALYZE TABLE satislar;` |
| `AND` | Evet | `WHERE` veya `HAVING`'de birden fazla koşulu birleştiren mantıksal operatördür. Ayrılmış kelimedir. | `SELECT * FROM urunler WHERE fiyat > 100 AND kategori = 'Elektronik';` |
| `AS` | Evet | Sütun veya tablolara geçici bir takma ad (alias) verir. Ayrılmış kelimedir. | `SELECT musteri_adi AS Isim, musteri_soyadi AS Soyisim FROM musteriler;` |
| `ASC` | Evet | `ORDER BY` ile sonuçları artan sırayla sıralar. Varsayılan sıralama türüdür. Ayrılmış kelimedir. | `SELECT * FROM personeller ORDER BY soyad ASC;` |
| `AUTO_INCREMENT`| Hayır | Sütuna her yeni kayıt eklendiğinde otomatik olarak ardışık değer atanmasını sağlar. | `CREATE TABLE kayitlar (id INT AUTO_INCREMENT PRIMARY KEY);` |

## B

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `BEFORE` | Evet | Bir `TRIGGER`'ın ilişkili DML işleminden önce çalışacağını belirtir. Ayrılmış kelimedir. | `CREATE TRIGGER log_before_delete BEFORE DELETE ON maaslar ...` |
| `BETWEEN` | Evet | `WHERE`'de bir değerin belirli bir aralıkta (sınırlar dahil) olup olmadığını kontrol eder. | `SELECT * FROM siparisler WHERE tarih BETWEEN '2025-01-01' AND '2025-03-31';` |
| `BIGINT` | Evet | Büyük tamsayıları saklamak için kullanılan bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE istatistikler (ziyaret_sayisi BIGINT);` |
| `BINARY` | Evet | İkili verileri belirtir veya karakter karşılaştırmasını büyük/küçük harfe duyarlı yapar. Ayrılmış kelimedir. | `SELECT * FROM kullanicilar WHERE BINARY kullanici_adi = 'Admin';` |
| `BLOB` | Evet | Büyük ikili nesneleri (dosya, resim vb.) saklamak için kullanılan veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE dosyalar (id INT, icerik BLOB);` |
| `BOTH` | Evet | `TRIM()` fonksiyonunda bir karakterin hem baştan hem sondan kaldırılacağını belirtir. | `SELECT TRIM(BOTH ' ' FROM '  test  ');` |
| `BY` | Evet | `ORDER BY` (sıralama) veya `GROUP BY` (gruplama) yan tümcelerinin bir parçasıdır. Ayrılmış kelimedir. | `SELECT kategori, COUNT(*) FROM urunler GROUP BY kategori;` |

## C

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `CALL` | Evet | Saklı bir yordamı (stored procedure) çağırmak için kullanılır. Ayrılmış kelimedir. | `CALL KullaniciGetir(123);` |
| `CASCADE` | Evet | Yabancı anahtar kısıtlamalarında, ana tablodaki bir kayıt silindiğinde/güncellendiğinde ilişkili kayıtların da silinmesini/güncellenmesini sağlar. | `FOREIGN KEY (id) REFERENCES t(id) ON DELETE CASCADE;` |
| `CASE` | Evet | SQL'de `IF-THEN-ELSE` benzeri koşullu mantık oluşturmayı sağlar. Ayrılmış kelimedir. | `SELECT CASE WHEN not > 50 THEN 'Geçti' ELSE 'Kaldı' END FROM sinavlar;` |
| `CHANGE` | Evet | `ALTER TABLE` ile bir sütunun adını ve tanımını değiştirmek için kullanılır. Ayrılmış kelimedir. | `ALTER TABLE kullanicilar CHANGE COLUMN eski_ad yeni_ad VARCHAR(100);` |
| `CHAR` | Evet | Sabit uzunluklu karakter dizilerini saklayan bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE kodlar (posta_kodu CHAR(5));` |
| `CHECK` | Evet | Bir sütuna girilebilecek değerleri kısıtlayan bir `CONSTRAINT` (kısıtlama) tanımlar. Ayrılmış kelimedir. | `CREATE TABLE urunler (fiyat INT, CHECK (fiyat > 0));` |
| `COLLATE` | Evet | Karakter setleri için karşılaştırma ve sıralama kurallarını (harf duyarlılığı vb.) belirtir. Ayrılmış kelimedir. | `CREATE TABLE metinler (veri VARCHAR(50)) COLLATE utf8mb4_turkish_ci;` |
| `COLUMN` | Evet | Tablo yapısı işlemlerinde (örn: `ADD COLUMN`) sütunları ifade eder. Ayrılmış kelimedir. | `ALTER TABLE musteriler ADD COLUMN telefon VARCHAR(20);` |
| `CONDITION` | Evet | `DECLARE ... CONDITION` ile saklı yordamlarda özel hata durumları tanımlar. Ayrılmış kelimedir. | `DECLARE gecersiz_id CONDITION FOR SQLSTATE '45000';` |
| `CONSTRAINT` | Evet | Tabloya `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK` gibi bir kısıtlama eklerken kullanılır. Ayrılmış kelimedir. | `ALTER TABLE siparisler ADD CONSTRAINT fk_musteri FOREIGN KEY (musteri_id)...` |
| `CONTINUE` | Evet | Saklı yordamlar içindeki döngülerde, mevcut döngü adımını atlayıp bir sonrakine geçmeyi sağlar. | `label: LOOP ... IF condition THEN LEAVE label; END IF; ... END LOOP;` |
| `CONVERT` | Evet | `CAST` fonksiyonu gibi, bir değeri bir veri tipinden diğerine dönüştürür. Ayrılmış kelimedir. | `SELECT CONVERT('123', UNSIGNED INTEGER);` |
| `CREATE` | Evet | Veritabanı, tablo, dizin, kullanıcı gibi yeni nesneler oluşturan DDL komutudur. Ayrılmış kelimedir. | `CREATE TABLE yeni_tablo (id INT, ad VARCHAR(50));` |
| `CROSS` | Evet | `CROSS JOIN`, iki tablonun kartezyen çarpımını (her satırın diğer tablodaki her satırla eşleşmesi) döndürür. | `SELECT * FROM urunler CROSS JOIN renkler;` |
| `CURRENT_TIMESTAMP` | Evet | Fonksiyon olarak çağrıldığında o anki tarih ve saati döndürür. Ayrılmış kelimedir. | `INSERT INTO loglar (zaman) VALUES (CURRENT_TIMESTAMP);` |
| `CURSOR` | Evet | Saklı yordamlar içinde bir sonuç kümesi üzerinde satır satır gezinmeyi sağlayan bir yapıdır. Ayrılmış kelimedir. | `DECLARE cur CURSOR FOR SELECT id, ad FROM musteriler;` |

## D

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `DATABASE` | Evet | Bir veritabanı oluşturmak (`CREATE DATABASE`) veya kullanmak (`USE DATABASE`) için kullanılır. Ayrılmış kelimedir. | `CREATE DATABASE sirket_veritabani;` |
| `DECIMAL` | Evet | Sabit noktalı sayıları (para birimi gibi) tam hassasiyetle saklayan bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE hesaplar (bakiye DECIMAL(12, 2));` |
| `DECLARE` | Evet | Saklı yordamlar ve fonksiyonlar içinde yerel değişkenler, koşullar veya `CURSOR`'lar tanımlar. Ayrılmış kelimedir. | `DECLARE toplam_satis INT DEFAULT 0;` |
| `DEFAULT` | Evet | Bir sütuna veri girilmediğinde atanacak varsayılan değeri belirtir. Ayrılmış kelimedir. | `CREATE TABLE ayarlar (tema VARCHAR(20) DEFAULT 'açık');` |
| `DELETE` | Evet | Bir tablodan bir veya daha fazla satırı silmek için kullanılan DML komutudur. Ayrılmış kelimedir. | `DELETE FROM siparisler WHERE durum = 'iptal edildi';` |
| `DESC` | Evet | `ORDER BY` ile sonuçları azalan sırayla (Z'den A'ya, 9'dan 0'a) sıralar. Ayrılmış kelimedir. | `SELECT * FROM urunler ORDER BY fiyat DESC;` |
| `DESCRIBE` | Evet | Bir tablonun sütun yapısını (ad, tip, null durumu vb.) gösterir. `DESC` olarak kısaltılabilir. | `DESCRIBE musteriler;` |
| `DISTINCT` | Evet | `SELECT` sorgularında yinelenen satırları sonuç kümesinden kaldırır, yalnızca benzersiz değerleri gösterir. | `SELECT DISTINCT ulke FROM musteriler;` |
| `DROP` | Evet | Bir veritabanı nesnesini (tablo, veritabanı, dizin, kullanıcı) kalıcı olarak silen DDL komutudur. | `DROP TABLE eski_veriler;` |

## E - F

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `ELSE` | Evet | `CASE` ifadelerinde, önceki `WHEN` koşulları sağlanmazsa çalışacak olan bloğu belirtir. | `SELECT CASE WHEN ... THEN ... ELSE 'Diğer' END FROM tablo;` |
| `ENCLOSED` | Evet | `LOAD DATA INFILE` komutunda, metin dosyasındaki alanların hangi karakterle çevrelendiğini belirtir (örn: tırnak işareti). | `LOAD DATA INFILE 'veri.csv' ... FIELDS ENCLOSED BY '"';` |
| `ESCAPED` | Evet | `LOAD DATA INFILE` komutunda, özel karakterlerin nasıl "kaçış" (escape) yapıldığını belirtir (örn: `\`). | `LOAD DATA INFILE 'veri.csv' ... LINES ESCAPED BY '\\';` |
| `EXISTS` | Evet | Bir alt sorgunun en az bir satır döndürüp döndürmediğini kontrol eden bir koşuldur. Genellikle `WHERE`'de kullanılır. | `SELECT ad FROM saticilar WHERE EXISTS (SELECT 1 FROM siparisler ...);` |
| `EXPLAIN` | Evet | Bir `SELECT` sorgusunun MySQL tarafından nasıl yürütüleceğini (kullanılan dizinler, birleştirme türleri vb.) gösterir. | `EXPLAIN SELECT * FROM musteriler WHERE sehir = 'İstanbul';` |
| `FALSE` | Evet | `TRUE`'nun zıttı olan bir boolean (mantıksal) değerdir. Genellikle `0`'a eşdeğerdir. Ayrılmış kelimedir. | `SELECT * FROM urunler WHERE stokta_var = FALSE;` |
| `FETCH` | Evet | `CURSOR` ile birlikte, bir sonraki satırı getirmek ve değişkenlere atamak için kullanılır. Ayrılmış kelimedir. | `FETCH cur INTO musteri_id, musteri_adi;` |
| `FLOAT` | Evet | Tek duyarlıklı kayan noktalı sayıları saklayan bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE sensor_verileri (sicaklik FLOAT);` |
| `FOR` | Evet | `FOR EACH ROW` (trigger'larda), `FOR UPDATE` (satırları kilitlemek için) gibi çeşitli ifadelerin bir parçasıdır. Ayrılmış kelimedir. | `SELECT * FROM envanter WHERE urun_id = 1 FOR UPDATE;` |
| `FOREIGN` | Evet | Bir tablonun başka bir tabloyla ilişkisini tanımlayan `FOREIGN KEY` (yabancı anahtar) kısıtlamasının bir parçasıdır. | `ALTER TABLE siparisler ADD FOREIGN KEY (musteri_id) REFERENCES musteriler(id);` |
| `FROM` | Evet | `SELECT`, `DELETE`, `UPDATE` komutlarında verilerin hangi tablodan alınacağını veya işleneceğini belirtir. Ayrılmış kelimedir. | `SELECT ad, soyad FROM kullanicilar;` |
| `FULLTEXT` | Evet | Metin tabanlı sütunlarda gelişmiş kelime araması yapmayı sağlayan özel bir dizin (index) türüdür. | `CREATE FULLTEXT INDEX idx_baslik ON makaleler(baslik);` |
| `FUNCTION` | Evet | Kullanıcı tanımlı bir fonksiyon (UDF) veya saklı fonksiyon (stored function) oluşturur. Ayrılmış kelimedir. | `CREATE FUNCTION KDVHesapla(fiyat DECIMAL(10,2)) RETURNS DECIMAL(10,2)...` |

## G - H - I

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `GRANT` | Evet | Kullanıcılara veritabanları, tablolar veya sütunlar üzerinde belirli izinler (yetkiler) vermek için kullanılır. | `GRANT SELECT, INSERT ON sirket.* TO 'editor'@'localhost';` |
| `GROUP` | Evet | `GROUP BY` yan tümcesi, aynı değere sahip satırları tek bir özet satırında gruplamak için kullanılır. Genellikle `COUNT`, `SUM` gibi toplama fonksiyonlarıyla kullanılır. | `SELECT kategori, AVG(fiyat) FROM urunler GROUP BY kategori;` |
| `HAVING` | Evet | `GROUP BY` ile gruplanmış sonuçları filtrelemek için kullanılır. `WHERE`'den farkı, `HAVING`'in toplama fonksiyonları üzerinde koşul belirtebilmesidir. | `SELECT kategori, COUNT(*) FROM urunler GROUP BY kategori HAVING COUNT(*) > 10;` |
| `IF` | Evet | Saklı yordamlarda ve fonksiyonlarda koşullu mantık oluşturur. Ayrıca bir fonksiyon olarak da (`IF(kosul, dogru_deger, yanlis_deger)`) kullanılır. | `SELECT IF(stok > 0, 'Stokta Var', 'Tükendi') FROM urunler;` |
| `IGNORE` | Evet | `INSERT IGNORE`, yinelenen birincil anahtar veya `UNIQUE` dizin hatası oluştuğunda hata vermek yerine işlemi yok sayar. Ayrıca bir optimizer ipucudur. | `INSERT IGNORE INTO musteriler (id, eposta) VALUES (1, 'test@site.com');` |
| `IN` | Evet | Bir değerin, verilen bir liste veya alt sorgu sonuçları içinde olup olmadığını kontrol eder. `WHERE`'de kullanılır. | `SELECT * FROM musteriler WHERE sehir IN ('Ankara', 'İzmir', 'Bursa');` |
| `INDEX` | Evet | Tablolardaki verilere erişimi hızlandırmak için kullanılan bir veri yapısıdır. `CREATE INDEX` ile oluşturulur. | `CREATE INDEX idx_soyad ON personeller(soyad);` |
| `INNER` | Evet | `INNER JOIN`, iki tablodaki eşleşen satırları birleştiren bir `JOIN` türüdür. `JOIN` ile aynı anlama gelir. | `SELECT * FROM siparisler INNER JOIN musteriler ON siparisler.musteri_id = musteriler.id;` |
| `INSERT` | Evet | Bir tabloya yeni bir satır (kayıt) eklemek için kullanılan DML komutudur. Ayrılmış kelimedir. | `INSERT INTO urunler (ad, fiyat) VALUES ('Kalem', 5.75);` |
| `INT` | Evet | Tamsayıları saklamak için kullanılan yaygın bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE kullanicilar (id INT PRIMARY KEY, yas INT);` |
| `INTERVAL` | Evet | Tarih ve saat hesaplamalarında bir zaman aralığı belirtmek için kullanılır (örn: 1 GÜN, 3 AY). | `SELECT NOW() + INTERVAL 1 MONTH;` |
| `INTO` | Evet | `INSERT INTO` komutunda verinin hangi tabloya ekleneceğini belirtir. `SELECT ... INTO` ile sorgu sonucunu değişkenlere atar. | `INSERT INTO loglar (mesaj) VALUES ('İşlem başarılı.');` |
| `IS` | Evet | Genellikle `IS NULL` veya `IS NOT NULL` şeklinde bir değerin `NULL` olup olmadığını kontrol etmek için kullanılır. | `SELECT * FROM musteriler WHERE telefon IS NULL;` |

## J - K - L

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `JOIN` | Evet | İki veya daha fazla tabloyu ilişkili sütunlar üzerinden birleştirmek için kullanılır. | `SELECT * FROM siparisler JOIN musteriler ON siparisler.musteri_id = musteriler.id;` |
| `KEY` | Evet | `INDEX` kelimesinin eş anlamlısıdır. Bir sütunun dizin olduğunu belirtir. `PRIMARY KEY`'in bir parçasıdır. | `CREATE TABLE t (id INT, PRIMARY KEY (id));` |
| `KILL` | Evet | Bir MySQL bağlantısını veya sorgusunu sonlandırmak için kullanılır. | `KILL 12345;` (12345 bağlantı ID'sidir) |
| `LEAVE` | Evet | Saklı yordamlar içinde bir döngüden veya `BEGIN...END` bloğundan çıkmayı sağlar. | `my_loop: LOOP IF i > 10 THEN LEAVE my_loop; END IF; ... END LOOP;` |
| `LEFT` | Evet | `LEFT JOIN`, sol tablodaki tüm satırları ve sağ tablodaki eşleşen satırları döndürür. Eşleşme yoksa sağ taraf `NULL` olur. | `SELECT m.ad, s.id FROM musteriler m LEFT JOIN siparisler s ON m.id = s.musteri_id;` |
| `LIKE` | Evet | `WHERE`'de, bir karakter dizisinin belirli bir kalıpla eşleşip eşleşmediğini kontrol eder. `%` (herhangi bir karakter dizisi) ve `_` (tek karakter) jokerlerini kullanır. | `SELECT * FROM urunler WHERE ad LIKE 'Bilgisayar%';` |
| `LIMIT` | Evet | Bir sorgunun döndüreceği maksimum satır sayısını sınırlar. Sayfalama işlemlerinde sıkça kullanılır. | `SELECT * FROM haberler ORDER BY tarih DESC LIMIT 10;` |
| `LOAD` | Evet | `LOAD DATA INFILE` komutu, bir metin dosyasından bir tabloya toplu veri yüklemek için kullanılır. | `LOAD DATA INFILE '/tmp/data.txt' INTO TABLE analiz_verileri;` |
| `LOCK` | Evet | `LOCK TABLES` ile işlem tutarlılığı için tabloları kilitler. `FOR UPDATE` ile satırları kilitler. Ayrılmış kelimedir. | `LOCK TABLES satislar WRITE;` |
| `LONGTEXT` | Evet | Çok uzun metin verilerini saklamak için kullanılan bir `TEXT` veri tipidir. | `CREATE TABLE blog_yazilari (icerik LONGTEXT);` |
| `LOOP` | Evet | Saklı yordamlar içinde tekrarlayan işlemler için bir döngü oluşturur. | `my_label: LOOP ... LEAVE my_label; END LOOP;` |

## M - N - O

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `MATCH` | Evet | `FULLTEXT` aramalarda, arama yapılacak sütunları belirtir ve `AGAINST` ile kullanılır. | `SELECT * FROM makaleler WHERE MATCH(baslik, icerik) AGAINST('SQL');` |
| `NOT` | Evet | Bir koşulun, operatörün veya ifadenin anlamını tersine çevirir (`NOT NULL`, `NOT IN`, `NOT LIKE`). | `SELECT * FROM musteriler WHERE sehir NOT IN ('İstanbul');` |
| `NULL` | Evet | Bir alanda değerin olmadığını, bilinmediğini veya tanımsız olduğunu ifade eden özel bir belirteçtir. | `INSERT INTO personeller (ad, soyad, telefon) VALUES ('Ali', 'Veli', NULL);` |
| `ON` | Evet | `JOIN` ifadelerinde tabloların hangi sütunlar üzerinden birleştirileceğini belirtir. `GRANT ... ON` ile yetkinin hangi nesneye verildiğini belirtir. | `SELECT * FROM A JOIN B ON A.id = B.a_id;` |
| `OPTIMIZE` | Evet | Bir tablonun parçalanmış verilerini birleştirerek ve dizinleri yeniden düzenleyerek performansı ve disk kullanımını iyileştirir. | `OPTIMIZE TABLE buyuk_tablo;` |
| `OPTION` | Evet | `SET` komutu gibi çeşitli komutlarda seçenek belirtmek için kullanılır. | `SET GLOBAL max_connections = 200;` |
| `OR` | Evet | `WHERE` veya `HAVING`'de, belirtilen koşullardan en az birinin doğru olması durumunda satırları döndüren mantıksal operatördür. | `SELECT * FROM urunler WHERE kategori = 'Telefon' OR kategori = 'Tablet';` |
| `ORDER` | Evet | `ORDER BY` yan tümcesi, bir sorgunun sonuç kümesini bir veya daha fazla sütuna göre sıralar. | `SELECT * FROM calisanlar ORDER BY soyad, ad;` |
| `OUTER` | Evet | `LEFT OUTER JOIN` veya `RIGHT OUTER JOIN`'de kullanılır. `OUTER` kelimesi genellikle isteğe bağlıdır ve atlanabilir. | `SELECT * FROM A LEFT OUTER JOIN B ON A.id = B.id;` |

## P - Q - R

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `PARTITION` | Evet | Çok büyük tabloları, yönetimi ve sorgulamayı kolaylaştırmak için daha küçük parçalara (partition) ayırma işlemini yönetir. | `CREATE TABLE satislar (satis_tarihi DATE) PARTITION BY RANGE(YEAR(satis_tarihi)) ...` |
| `PRIMARY` | Evet | Bir tablodaki her satırı benzersiz şekilde tanımlayan `PRIMARY KEY` (birincil anahtar) kısıtlamasının bir parçasıdır. | `CREATE TABLE kullanicilar (id INT, PRIMARY KEY(id));` |
| `PROCEDURE` | Evet | `CREATE PROCEDURE` ile saklı bir yordam (veritabanında saklanan bir SQL komutları bloğu) oluşturur. | `CREATE PROCEDURE TumMusterileriGetir() BEGIN SELECT * FROM musteriler; END;` |
| `PURGE` | Evet | İkili log (binary log) dosyalarını belirli bir tarih veya dosyadan öncesini silmek için kullanılır. | `PURGE BINARY LOGS TO 'mysql-bin.000123';` |
| `RANGE` | Evet | `PARTITION BY RANGE` gibi ifadelerde bir aralık belirtmek için kullanılır. | `... PARTITION p1 VALUES LESS THAN (2020), PARTITION p2 VALUES LESS THAN (2021)` |
| `READ` | Evet | `LOCK TABLES ... READ` ile bir tabloya sadece okuma kilidi koyar. `READ_ONLY` sistem değişkeni ile kullanılır. | `LOCK TABLES musteriler READ;` |
| `REFERENCES` | Evet | Bir `FOREIGN KEY`'in hangi tablonun hangi sütununa başvurduğunu (referans verdiğini) belirtir. | `... FOREIGN KEY (musteri_id) REFERENCES musteriler(id);` |
| `REGEXP` | Evet | `RLIKE` operatörünün eş anlamlısıdır. Bir değerin düzenli bir ifade (regular expression) ile eşleşip eşleşmediğini kontrol eder. | `SELECT * FROM epostalar WHERE adres REGEXP '^[a-z]+@[a-z]+\.com$';` |
| `RELEASE` | Evet | `GET_LOCK` ile alınan isimlendirilmiş bir kilidi serbest bırakır. `RELEASE_LOCK` fonksiyonuyla kullanılır. | `SELECT RELEASE_LOCK('my_lock');` |
| `RENAME` | Evet | `RENAME TABLE` veya `ALTER TABLE ... RENAME` ile bir tablonun adını değiştirir. | `RENAME TABLE eski_tablo TO yeni_tablo;` |
| `REPLACE` | Evet | `INSERT`'e benzer şekilde çalışır, ancak eklenen kaydın birincil veya benzersiz anahtarı mevcut bir kayıtla çakışırsa, eski kaydı siler ve yenisini ekler. | `REPLACE INTO ayarlar (id, deger) VALUES (1, 'yeni_deger');` |
| `REQUIRE` | Evet | `GRANT` komutunda, bir kullanıcının bağlantı kurarken SSL/TLS gibi güvenlik protokolleri kullanmasını zorunlu kılar. | `GRANT USAGE ON *.* TO 'user'@'host' REQUIRE SSL;` |
| `RESTRICT` | Evet | `FOREIGN KEY`'lerde `NO ACTION`'ın eş anlamlısıdır. Ana kaydın silinmesini/güncellenmesini engeller. | `... ON DELETE RESTRICT;` |
| `RETURN` | Evet | Saklı bir fonksiyonda (stored function) bir değer döndürmek için kullanılır. | `CREATE FUNCTION Topla(a INT, b INT) RETURNS INT ... RETURN a + b;` |
| `REVOKE` | Evet | `GRANT`'ın tersidir; bir kullanıcıdan daha önce verilmiş izinleri (yetkileri) geri alır. | `REVOKE INSERT ON sirket.* FROM 'editor'@'localhost';` |
| `RIGHT` | Evet | `RIGHT JOIN`, sağ tablodaki tüm satırları ve sol tablodaki eşleşen satırları döndürür. Eşleşme yoksa sol taraf `NULL` olur. | `SELECT * FROM siparisler s RIGHT JOIN musteriler m ON s.musteri_id = m.id;` |
| `ROLLBACK` | Hayır | Bir `TRANSACTION` (işlem) bloğu içindeki tüm değişiklikleri geri alır ve işlemi sonlandırır. | `START TRANSACTION; ... ROLLBACK;` |

## S

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `SCHEMA` | Evet | `DATABASE` kelimesinin eş anlamlısıdır. Genellikle veritabanının mantıksal yapısını ifade eder. | `CREATE SCHEMA sirket_veritabani;` |
| `SELECT` | Evet | Bir veya daha fazla tablodan veri sorgulamak için kullanılan temel DML komutudur. Ayrılmış kelimedir. | `SELECT ad, soyad FROM kullanicilar WHERE sehir = 'Ankara';` |
| `SET` | Evet | Bir oturum (session) veya genel (global) sistem değişkeninin değerini değiştirmek için kullanılır. | `SET NAMES 'utf8mb4';` |
| `SHOW` | Evet | Veritabanları, tablolar, süreçler, değişkenler gibi çeşitli MySQL bilgilerini listelemek için kullanılır. | `SHOW DATABASES;` veya `SHOW TABLES;` |
| `SIGNAL` | Evet | Saklı yordamlar içinde özel bir hata durumu oluşturmak ve bir hata mesajı fırlatmak için kullanılır. | `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok yetersiz.';` |
| `SMALLINT` | Evet | Küçük tamsayıları saklamak için kullanılan bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE siparis_detay (adet SMALLINT);` |
| `SPATIAL` | Evet | Coğrafi ve geometrik veriler (`POINT`, `POLYGON` vb.) üzerinde verimli arama yapmak için özel bir dizin türü oluşturur. | `CREATE SPATIAL INDEX idx_konum ON harita_verileri(koordinat);` |
| `SQL_BIG_RESULT`| Evet | Sorgu iyileştiriciye, sonuç kümesinin çok büyük olacağını ve geçici disk tablolarını daha verimli kullanması gerektiğini bildiren bir ipucudur. | `SELECT SQL_BIG_RESULT DISTINCT ... FROM ...;` |
| `SSL` | Evet | `REQUIRE SSL` gibi ifadelerde güvenli bağlantı (SSL/TLS) kullanımını belirtir. | `ALTER USER 'secure_user'@'host' REQUIRE SSL;` |
| `STARTING` | Evet | `LOAD DATA INFILE` komutunda, metin dosyasındaki satırların başındaki karakterleri belirtir. | `LOAD DATA ... LINES STARTING BY 'prefix_';` |
| `STORED` | Evet | Üretilmiş sütunların (generated columns) değerinin her satır yazıldığında hesaplanıp saklanacağını belirtir. `VIRTUAL`'ın zıttıdır. | `CREATE TABLE t (a INT, b INT, c INT AS (a+b) STORED);` |
| `STRAIGHT_JOIN`| Evet | Sorgu iyileştiriciye, tabloları `FROM` yan tümcesinde belirtilen sırada birleştirmesi için zorlayan bir ipucudur. | `SELECT * FROM tablo1 STRAIGHT_JOIN tablo2 ON tablo1.id = tablo2.id;` |

## T

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `TABLE` | Evet | Tablo oluşturma (`CREATE TABLE`), değiştirme (`ALTER TABLE`) veya silme (`DROP TABLE`) gibi komutlarda kullanılır. | `CREATE TABLE personeller (id INT, ad VARCHAR(50));` |
| `TERMINATED` | Evet | `LOAD DATA INFILE` komutunda, alanları (sütunları) birbirinden ayıran karakteri belirtir (örn: virgül, tab). | `LOAD DATA ... FIELDS TERMINATED BY ',';` |
| `THEN` | Evet | `CASE` ifadelerinde, bir `WHEN` koşulu doğru olduğunda çalışacak olan sonucu veya ifadeyi belirtir. | `CASE WHEN durum = 1 THEN 'Geçti' ... END` |
| `TINYINT` | Evet | Çok küçük tamsayıları (`-128` ile `127` arası) saklayan bir veri tipidir. Genellikle boolean değerler (0 veya 1) için kullanılır. | `CREATE TABLE ayarlar (aktif TINYINT(1) DEFAULT 1);` |
| `TO` | Evet | `GRANT ... TO ...`, `RENAME TABLE ... TO ...` gibi ifadelerde hedefi (kullanıcı, yeni tablo adı) belirtir. | `GRANT SELECT ON db.* TO 'rapor_kullanici'@'%';` |
| `TRAILING` | Evet | `TRIM` fonksiyonunda, bir karakterin yalnızca sondan kaldırılacağını belirtir. | `SELECT TRIM(TRAILING '.' FROM 'test.com.');` |
| `TRANSACTION` | Hayır | Bir bütün olarak başarılı olması veya başarısız olması gereken bir dizi SQL işlemini başlatır (`START TRANSACTION`). | `START TRANSACTION; UPDATE hesaplar SET bakiye = bakiye - 100 WHERE id = 1; COMMIT;` |
| `TRIGGER` | Evet | Bir DML olayı (`INSERT`, `UPDATE`, `DELETE`) gerçekleştiğinde otomatik olarak çalışan özel bir saklı yordam türüdür. | `CREATE TRIGGER log_guncelleme AFTER UPDATE ON musteriler FOR EACH ROW ...` |
| `TRUE` | Evet | `FALSE`'un zıttı olan bir boolean (mantıksal) değerdir. Genellikle `1`'e eşdeğerdir. Ayrılmış kelimedir. | `SELECT * FROM kullanicilar WHERE aktif = TRUE;` |
| `TRUNCATE` | Hayır | `TRUNCATE TABLE`, bir tablodaki tüm satırları çok hızlı bir şekilde siler. `DELETE`'ten farklı olarak geri alınamaz ve tetikleyicileri çalıştırmaz. | `TRUNCATE TABLE log_kayitlari;` |

## U

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `UNDO` | Evet | `UNDO TABLESPACE` gibi ifadelerde geri alma (undo) logları ile ilgili işlemleri belirtir. | `CREATE UNDO TABLESPACE ts1 ADD DATAFILE 'undo_1.ibu';` |
| `UNION` | Evet | İki veya daha fazla `SELECT` sorgusunun sonuç kümelerini birleştirir ve yinelenen satırları varsayılan olarak kaldırır. | `SELECT ad FROM calisanlar UNION SELECT ad FROM yoneticiler;` |
| `UNIQUE` | Evet | Bir sütundaki veya sütun grubundaki tüm değerlerin benzersiz (tekrarsız) olmasını sağlayan bir kısıtlama veya dizin türüdür. | `CREATE TABLE kullanicilar (eposta VARCHAR(100), UNIQUE (eposta));` |
| `UNLOCK` | Evet | `LOCK TABLES` ile konulmuş olan kilitleri kaldırır. | `UNLOCK TABLES;` |
| `UNSIGNED` | Evet | Sayısal bir veri tipinin (örn: `INT`) sadece pozitif değerler ve sıfırı içermesini sağlar, böylece pozitif değer aralığını iki katına çıkarır. | `CREATE TABLE urunler (stok_miktari INT UNSIGNED);` |
| `UPDATE` | Evet | Bir tablodaki mevcut satırların bir veya daha fazla sütununu değiştirmek için kullanılan DML komutudur. | `UPDATE musteriler SET telefon = '555-1234' WHERE id = 10;` |
| `USAGE` | Evet | `GRANT USAGE`, bir kullanıcıya veritabanına bağlanma izni verir, ancak başka hiçbir yetki vermez. En temel yetkidir. | `GRANT USAGE ON *.* TO 'yeni_kullanici'@'localhost';` |
| `USE` | Evet | Komutların hangi veritabanı üzerinde çalışacağını belirtmek için varsayılan (aktif) veritabanını değiştirir. | `USE sirket_veritabani;` |
| `USING` | Evet | `JOIN` ifadelerinde, her iki tabloda da aynı ada sahip olan sütunlar üzerinden birleştirme yapmak için daha kısa bir yol sunar. | `SELECT * FROM A JOIN B USING(id);` |

## V - W

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `VALUES` | Evet | `INSERT INTO` komutunda, eklenecek olan yeni değerleri belirtir. | `INSERT INTO sehirler (id, ad) VALUES (34, 'İstanbul');` |
| `VARCHAR` | Evet | Değişken uzunluklu karakter dizilerini saklayan yaygın bir veri tipidir. Ayrılmış kelimedir. | `CREATE TABLE musteriler (ad VARCHAR(50), soyad VARCHAR(50));` |
| `VIEW` | Hayır | Bir veya daha fazla tablodan alınan verilere dayanan sanal bir tablodur. `CREATE VIEW` ile oluşturulur. | `CREATE VIEW aktif_kullanicilar AS SELECT * FROM kullanicilar WHERE aktif = 1;` |
| `VIRTUAL` | Evet | Üretilmiş sütunların (generated columns) değerinin saklanmadığını, her okunduğunda yeniden hesaplandığını belirtir. `STORED`'un zıttıdır. | `CREATE TABLE t (a INT, b INT, c INT AS (a+b) VIRTUAL);` |
| `WHEN` | Evet | `CASE` ifadelerinde bir koşul belirtmek için kullanılır. | `SELECT CASE WHEN durum = 1 THEN 'Aktif' WHEN durum = 0 THEN 'Pasif' END ...` |
| `WHERE` | Evet | `SELECT`, `UPDATE`, `DELETE` komutlarında hangi satırların işleneceğini filtreleyen koşul yan tümcesidir. | `SELECT * FROM urunler WHERE fiyat < 100;` |
| `WHILE` | Evet | Saklı yordamlar içinde, belirli bir koşul doğru olduğu sürece tekrarlayan bir döngü oluşturur. | `WHILE i < 10 DO ... SET i = i + 1; END WHILE;` |
| `WITH` | Evet | Ortak Tablo İfadeleri (Common Table Expressions - CTE) tanımlamak için kullanılır. Sorguları daha okunabilir hale getirir. | `WITH satis_ozeti AS (SELECT satici_id, SUM(tutar) FROM satislar GROUP BY satici_id) SELECT * FROM satis_ozeti;` |
| `WRITE` | Evet | `LOCK TABLES ... WRITE` ile bir tabloya yazma kilidi koyar (diğer bağlantılar ne okuyabilir ne yazabilir). | `LOCK TABLES siparisler WRITE;` |

## X - Y - Z

| Anahtar Kelime | Ayrılmış (R) | Kullanım Koşulları | Kullanım Örneği |
| :--- | :--- | :--- | :--- |
| `XOR` | Evet | Mantıksal bir operatördür. İki koşuldan yalnızca birinin doğru olması durumunda `TRUE` döndürür. | `SELECT * FROM anket WHERE (cevap_a = 1 XOR cevap_b = 1);` |
| `YEAR` | Hayır | Dört basamaklı yıl değerlerini saklayan bir veri tipidir. Ayrıca tarihten yıl kısmını çıkaran bir fonksiyondur. | `CREATE TABLE etkinlikler (etkinlik_yili YEAR);` |
| `ZEROFILL` | Evet | Sayısal bir sütunda, görüntülenen değerin sol tarafını, sütun genişliğine ulaşana kadar sıfırlarla doldurur. Sütunu otomatik olarak `UNSIGNED` yapar. | `CREATE TABLE seri_no (id INT(5) ZEROFILL);` |
