-- #############################################################################
-- ## MySQL 8.0 Anahtar Kelimeleri Kapsamlı Örnek Betiği
-- ## Senaryo: Basit bir E-Ticaret Veritabanı
-- #############################################################################

-- Betiğe başlamadan önce oturum (SESSION) ayarları yapılıyor.
-- Kullanılan anahtar kelimeler: SET, SESSION
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';


-- #############################################################################
-- ## 1. DDL (Veri Tanımlama Dili) - Veritabanı ve Tabloların Oluşturulması
-- #############################################################################

-- Önceki veritabanını (eğer varsa) güvenli bir şekilde sil.
-- Kullanılan anahtar kelimeler: DROP, DATABASE, SCHEMA, IF, EXISTS
DROP SCHEMA IF EXISTS E_Ticaret_OrnekDB;

-- Yeni bir veritabanı oluştur.
-- Kullanılan anahtar kelimeler: CREATE, DATABASE, SCHEMA, DEFAULT, CHARACTER, SET, COLLATE
CREATE DATABASE IF NOT EXISTS E_Ticaret_OrnekDB
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_turkish_ci;

-- Oluşturulan veritabanını aktif hale getir.
-- Kullanılan anahtar kelimeler: USE
USE E_Ticaret_OrnekDB;

-- Kategoriler tablosu: Ürünlerin kategorilerini tutar.
-- Kullanılan anahtar kelimeler: CREATE, TABLE, NOT, NULL, AUTO_INCREMENT, PRIMARY, KEY, UNIQUE, COMMENT
CREATE TABLE IF NOT EXISTS Kategoriler (
    kategori_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    kategori_adi VARCHAR(100) NOT NULL,
    ust_kategori_id INT UNSIGNED NULL,
    PRIMARY KEY (kategori_id),
    UNIQUE KEY idx_kategori_adi (kategori_adi),
    CONSTRAINT fk_ust_kategori FOREIGN KEY (ust_kategori_id) REFERENCES Kategoriler(kategori_id) ON DELETE SET NULL
) COMMENT='Ürün kategorilerini saklar';

-- Urunler tablosu: Satılan ürünlerin bilgilerini içerir.
-- Kullanılan anahtar kelimeler: INT, VARCHAR, DECIMAL, TEXT, LONGTEXT, ENUM, TIMESTAMP, DEFAULT, CURRENT_TIMESTAMP, UNSIGNED, ZEROFILL, CHECK, CONSTRAINT, GENERATED, ALWAYS, AS, VIRTUAL, STORED
CREATE TABLE IF NOT EXISTS Urunler (
    urun_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    urun_kodu CHAR(10) NOT NULL UNIQUE,
    urun_adi VARCHAR(255) NOT NULL,
    aciklama TEXT,
    detayli_bilgi LONGTEXT,
    kategori_id INT UNSIGNED,
    fiyat DECIMAL(10, 2) UNSIGNED NOT NULL,
    stok_miktari SMALLINT UNSIGNED DEFAULT 0,
    agirlik_kg FLOAT,
    garanti_durumu TINYINT(1) DEFAULT 1,
    urun_durumu ENUM('Yeni', 'Kullanılmış', 'Yenilenmiş') DEFAULT 'Yeni',
    eklenme_zamani TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seri_no INT(8) ZEROFILL,
    kdv_dahil_fiyat DECIMAL(10, 2) GENERATED ALWAYS AS (fiyat * 1.18) STORED,
    CONSTRAINT fk_urun_kategori FOREIGN KEY (kategori_id) REFERENCES Kategoriler(kategori_id),
    CONSTRAINT chk_fiyat_pozitif CHECK (fiyat > 0)
);

-- Musteriler tablosu: Müşteri bilgilerini saklar.
-- Kullanılan anahtar kelimeler: DATE, JSON, SPATIAL, POINT
CREATE TABLE IF NOT EXISTS Musteriler (
    musteri_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    eposta VARCHAR(120) NOT NULL UNIQUE,
    sifre_hash VARBINARY(255) NOT NULL,
    dogum_tarihi DATE,
    adres_bilgileri JSON,
    konum GEOMETRY,
    kayit_tarihi DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Siparisler tablosu: Müşteri siparişlerinin ana bilgilerini tutar.
CREATE TABLE IF NOT EXISTS Siparisler (
    siparis_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT UNSIGNED NOT NULL,
    siparis_tarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    toplam_tutar DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_siparis_musteri FOREIGN KEY (musteri_id) REFERENCES Musteriler(musteri_id) ON DELETE CASCADE
);

-- Siparis_Detaylari tablosu: Her siparişteki ürünleri ve adetlerini listeler.
-- Kullanılan anahtar kelimeler: ON, UPDATE, CASCADE, RESTRICT
CREATE TABLE IF NOT EXISTS Siparis_Detaylari (
    siparis_detay_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    siparis_id BIGINT UNSIGNED NOT NULL,
    urun_id BIGINT UNSIGNED NOT NULL,
    adet INT UNSIGNED NOT NULL,
    birim_fiyat DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (siparis_id) REFERENCES Siparisler(siparis_id) ON DELETE CASCADE,
    FOREIGN KEY (urun_id) REFERENCES Urunler(urun_id) ON UPDATE RESTRICT
);

-- #############################################################################
-- ## 2. DDL - Mevcut Yapıyı Değiştirme (ALTER) ve Diğer Nesneler
-- #############################################################################

-- Musteriler tablosuna yeni bir sütun ekle.
-- Kullanılan anahtar kelimeler: ALTER, TABLE, ADD, COLUMN, AFTER
ALTER TABLE Musteriler
    ADD COLUMN telefon VARCHAR(20) AFTER eposta;

-- Urunler tablosundaki bir sütunun tanımını değiştir.
-- Kullanılan anahtar kelimeler: CHANGE, COLUMN
ALTER TABLE Urunler
    CHANGE COLUMN aciklama urun_aciklamasi TEXT;

-- Dizin (INDEX) oluşturarak sorgu performansını artır.
-- Kullanılan anahtar kelimeler: CREATE, INDEX, FULLTEXT, SPATIAL
CREATE INDEX idx_soyad ON Musteriler(soyad);
CREATE FULLTEXT INDEX idx_ft_urun_bilgi ON Urunler(urun_adi, urun_aciklamasi);
CREATE SPATIAL INDEX idx_sp_konum ON Musteriler(konum);

-- Sanal bir tablo (VIEW) oluştur.
-- Kullanılan anahtar kelimeler: CREATE, VIEW, AS
CREATE VIEW VW_Musteri_Siparis_Ozet AS
    SELECT M.ad, M.soyad, S.siparis_id, S.toplam_tutar
    FROM Musteriler AS M
    JOIN Siparisler AS S ON M.musteri_id = S.musteri_id;


-- #############################################################################
-- ## 3. DML (Veri İşleme Dili) - Veri Ekleme, Güncelleme, Silme
-- #############################################################################

-- Tablolara örnek veriler ekle.
-- Kullanılan anahtar kelimeler: INSERT, INTO, VALUES, NULL
INSERT INTO Kategoriler (kategori_adi, ust_kategori_id) VALUES ('Elektronik', NULL), ('Bilgisayar', 1), ('Telefon', 1);
INSERT INTO Urunler (urun_kodu, urun_adi, kategori_id, fiyat, stok_miktari) VALUES
    ('BLG001', 'Dizüstü Bilgisayar', 2, 15000.00, 50),
    ('TEL001', 'Akıllı Telefon', 3, 8000.00, 120);

-- Yinelenen anahtar hatasını görmezden gelerek ekleme yap (IGNORE).
-- Kullanılan anahtar kelimeler: INSERT, IGNORE
INSERT IGNORE INTO Kategoriler (kategori_id, kategori_adi) VALUES (1, 'Elektronik');

-- Kayıt varsa güncelle, yoksa ekle (REPLACE).
-- Kullanılan anahtar kelimeler: REPLACE
REPLACE INTO Urunler (urun_id, urun_kodu, urun_adi, kategori_id, fiyat) VALUES (1, 'BLG001-YENI', 'Yeni Dizüstü Bilgisayar', 2, 16500.00);

-- Veri güncelleme.
-- Kullanılan anahtar kelimeler: UPDATE, SET, WHERE
UPDATE Urunler SET stok_miktari = stok_miktari - 1 WHERE urun_id = 1;

-- Veri silme.
-- Kullanılan anahtar kelimeler: DELETE, FROM
-- DELETE FROM Urunler WHERE stok_miktari = 0; -- (Bu satır çalıştırılırsa sonraki sorgular etkilenebilir)


-- #############################################################################
-- ## 4. Saklı Yordamlar, Fonksiyonlar ve Tetikleyiciler
-- #############################################################################

-- Komut ayıracını değiştir.
-- Kullanılan anahtar kelimeler: DELIMITER
DELIMITER //

-- Yeni bir sipariş oluşturan Saklı Yordam (Stored Procedure).
-- Kullanılan anahtar kelimeler: CREATE, PROCEDURE, IN, OUT, BEGIN, END, DECLARE, TRANSACTION, COMMIT, ROLLBACK, SIGNAL, SQLSTATE, MESSAGE_TEXT, HANDLER, FOR, SQLEXCEPTION
CREATE PROCEDURE sp_YeniSiparisOlustur(IN p_musteri_id INT, OUT p_yeni_siparis_id BIGINT)
BEGIN
    DECLARE v_toplam_tutar DECIMAL(12, 2) DEFAULT 0.00;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL; -- Hatayı çağıran yere geri fırlat
    END;

    -- Örnek olarak toplam tutarı sabit bir değer olarak alıyoruz.
    SET v_toplam_tutar = 199.99;

    IF v_toplam_tutar <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sipariş tutarı pozitif olmalıdır.';
    END IF;

    START TRANSACTION;
        INSERT INTO Siparisler (musteri_id, toplam_tutar) VALUES (p_musteri_id, v_toplam_tutar);
        SET p_yeni_siparis_id = LAST_INSERT_ID();
    COMMIT;
END//


-- Bir ürünün KDV'li fiyatını hesaplayan Saklı Fonksiyon (Stored Function).
-- Kullanılan anahtar kelimeler: CREATE, FUNCTION, RETURNS, DETERMINISTIC, RETURN
CREATE FUNCTION fn_KDVliFiyatHesapla(p_fiyat DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_kdvli_fiyat DECIMAL(10,2);
    SET v_kdvli_fiyat = p_fiyat * 1.18;
    RETURN v_kdvli_fiyat;
END//

-- Sipariş detayı eklendiğinde ürün stoğunu güncelleyen Tetikleyici (Trigger).
-- Kullanılan anahtar kelimeler: CREATE, TRIGGER, AFTER, INSERT, ON, FOR, EACH, ROW, NEW
CREATE TRIGGER trg_StokGuncelle_AI
AFTER INSERT ON Siparis_Detaylari
FOR EACH ROW
BEGIN
    UPDATE Urunler
    SET stok_miktari = stok_miktari - NEW.adet
    WHERE urun_id = NEW.urun_id;
END//

-- Komut ayıracını eski haline getir.
DELIMITER ;


-- #############################################################################
-- ## 5. DQL (Veri Sorgulama Dili) - Kapsamlı Sorgu Örnekleri
-- #############################################################################

-- Temel sorgu.
-- Kullanılan anahtar kelimeler: SELECT, FROM, WHERE, AND, OR, LIKE, ORDER, BY, ASC, DESC, LIMIT
SELECT urun_id, urun_adi, fiyat
FROM Urunler
WHERE (fiyat > 5000 AND kategori_id = 2) OR urun_adi LIKE 'Akıllı%'
ORDER BY fiyat DESC, urun_adi ASC
LIMIT 10;

-- JOIN'ler ile birden fazla tabloyu birleştirme.
-- Kullanılan anahtar kelimeler: JOIN, INNER, LEFT, RIGHT, ON, USING
SELECT M.ad, S.siparis_id, U.urun_adi, SD.adet
FROM Musteriler M
INNER JOIN Siparisler S ON M.musteri_id = S.musteri_id
LEFT JOIN Siparis_Detaylari SD ON S.siparis_id = SD.siparis_id
RIGHT JOIN Urunler U USING(urun_id); -- 'USING' kullanımı için örnek

-- Gruplama ve gruplanmış veriyi filtreleme.
-- Kullanılan anahtar kelimeler: GROUP, BY, HAVING, COUNT, SUM, AVG
SELECT
    K.kategori_adi,
    COUNT(U.urun_id) AS urun_sayisi,
    AVG(U.fiyat) AS ortalama_fiyat
FROM Kategoriler K
JOIN Urunler U ON K.kategori_id = U.kategori_id
GROUP BY K.kategori_adi
HAVING COUNT(U.urun_id) > 0;

-- UNION ile sorgu sonuçlarını birleştirme.
-- Kullanılan anahtar kelimeler: UNION, ALL
(SELECT ad, soyad FROM Musteriler WHERE ad LIKE 'A%')
UNION ALL
(SELECT 'TEST', 'KULLANICI'); -- İkinci sorgu örnek amaçlı

-- Alt sorgu (subquery) kullanımı.
-- Kullanılan anahtar kelimeler: IN, EXISTS, ANY, ALL
SELECT urun_adi FROM Urunler
WHERE kategori_id IN (SELECT kategori_id FROM Kategoriler WHERE kategori_adi = 'Bilgisayar');

-- CTE (Common Table Expression - Ortak Tablo İfadesi) kullanımı.
-- Kullanılan anahtar kelimeler: WITH, AS
WITH KategoriUrunSayilari AS (
    SELECT kategori_id, COUNT(*) as sayi FROM Urunler GROUP BY kategori_id
)
SELECT K.kategori_adi, KUS.sayi
FROM Kategoriler K
JOIN KategoriUrunSayilari KUS ON K.kategori_id = KUS.kategori_id;

-- Pencere Fonksiyonları (Window Functions) kullanımı.
-- Kullanılan anahtar kelimeler: OVER, PARTITION, BY, ROW_NUMBER
SELECT
    urun_adi,
    kategori_adi,
    fiyat,
    ROW_NUMBER() OVER (PARTITION BY kategori_adi ORDER BY fiyat DESC) as kategori_sira
FROM Urunler U
JOIN Kategoriler K ON U.kategori_id = K.kategori_id;


-- #############################################################################
-- ## 6. Yönetimsel ve Diğer Komutlar (AÇIKLAMA AMAÇLI, ÇALIŞTIRMAYIN)
-- #############################################################################
/*
-- Bir sorgunun nasıl çalıştırıldığını analiz et.
-- Kullanılan anahtar kelimeler: EXPLAIN, ANALYZE
EXPLAIN ANALYZE SELECT * FROM Urunler WHERE urun_adi LIKE 'Dizüstü%';

-- Tabloyu optimize et.
-- Kullanılan anahtar kelimeler: OPTIMIZE, TABLE
OPTIMIZE TABLE Urunler;

-- Kullanıcıya yetki ver ve geri al.
-- Kullanılan anahtar kelimeler: GRANT, USAGE, SELECT, ON, TO, REQUIRE, SSL, REVOKE, FROM
GRANT SELECT ON E_Ticaret_OrnekDB.* TO 'rapor_kullanici'@'localhost';
REVOKE SELECT ON E_Ticaret_OrnekDB.* FROM 'rapor_kullanici'@'localhost';

-- Tabloları kilitle ve kilidi aç.
-- Kullanılan anahtar kelimeler: LOCK, TABLES, WRITE, READ, UNLOCK
LOCK TABLES Urunler WRITE, Kategoriler READ;
UNLOCK TABLES;

-- Bir bağlantıyı sonlandır.
-- Kullanılan anahtar kelimeler: KILL
-- KILL 12345; -- (12345 nolu bağlantıyı sonlandırır)

-- İkili logları temizle. (DİKKATLİ KULLANIN!)
-- Kullanılan anahtar kelimeler: PURGE, BINARY, LOGS, TO
-- PURGE BINARY LOGS TO 'mysql-bin.000150';

-- REPLICATION İLE İLGİLİ KOMUTLAR (Sunucu konfigürasyonunda kullanılır)
-- CHANGE MASTER TO ... / START SLAVE; / STOP SLAVE;
-- MySQL 8.0.22 sonrası: CHANGE REPLICATION SOURCE TO ... / START REPLICA;
*/

-- #############################################################################
-- ## Betik Sonu
-- #############################################################################
SELECT 'Ornek betik başarıyla çalıştırıldı.' AS Durum;
