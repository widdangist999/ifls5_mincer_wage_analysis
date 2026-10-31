# Interpretasi Hasil Ekonometrika (Output Stata)

**Judul penelitian:** Tingkat Pengembalian Pendidikan dan Kesenjangan Upah Gender di Indonesia: Analisis Komparasi Wilayah Urban dan Rural
**Data:** IFLS-5 (2014), *cross-section*, n = 3.989 (Urban 2.377; Rural 1.612)
**Model:** Persamaan Mincer, OLS, `vce(robust)`
**Variabel dependen:** `lnpendapatan` (log natural pendapatan bersih bulanan, tanpa penyesuaian jam kerja)

```
ln(Pendapatan) = β0 + β1·schooling + β2·experience + β3·experience² + β4·gender + β5·urban + ε
```

---

## 1. Cara Membaca Koefisien

Model berbentuk log-linear, sehingga koefisien β pada variabel independen dibaca sebagai perubahan **log points** pada pendapatan. Untuk koefisien kecil, β × 100 mendekati persen perubahan. Untuk koefisien besar (misalnya `gender`), gunakan konversi eksak **(exp(β) − 1) × 100**.

| Koefisien | β | Pembacaan aproksimasi | Konversi eksak |
|---|---|---|---|
| schooling (Full) | 0,0139579 | 1,40% | 1,41% |
| schooling (Urban) | 0,0145246 | 1,45% | 1,46% |
| schooling (Rural) | 0,0142636 | 1,43% | 1,44% |
| urban (Full) | 0,1256116 | 12,56% | 13,38% |
| gender (Full) | 0,2975414 | 29,75% | 34,65% |
| gender (Urban) | 0,2564972 | 25,65% | 29,24% |
| gender (Rural) | 0,3583979 | 35,84% | 43,10% |

Naskah memakai pembacaan aproksimasi. Konversi eksak sebaiknya disebut sebagai catatan kaki atau di bagian keterbatasan, terutama untuk `gender`.

---

## 2. Interpretasi Model Full (n = 3.989)

`regress lnpendapatan schooling experience experience2 urban gender, vce(robust)`

| Variabel | Koefisien | Robust SE | p-value | Interpretasi |
|---|---|---|---|---|
| schooling | 0,01396 | 0,00355 | 0,000 | Setiap tambahan 1 tahun sekolah berasosiasi dengan pendapatan sekitar 1,4% lebih tinggi, *ceteris paribus*. Ini adalah *return to education* pada pendapatan tanpa penyesuaian. |
| experience | 0,01959 | 0,00295 | 0,000 | Koefisien positif, efek pengalaman pada awal karier. Tidak boleh dibaca berdiri sendiri karena ada suku kuadrat. |
| experience² | −0,000372 | 0,0000521 | 0,000 | Koefisien negatif, efek pengalaman melambat lalu berbalik arah (kurva cekung/∩). |
| urban | 0,12561 | 0,02444 | 0,000 | Pekerja di kota berpendapatan sekitar 12,6% (eksak 13,4%) lebih tinggi daripada pekerja di desa pada tingkat pendidikan, pengalaman, dan gender yang sama (*urban wage premium*). |
| gender | 0,29754 | 0,02390 | 0,000 | Pekerja laki-laki berpendapatan sekitar 29,8% (eksak 34,6%) lebih tinggi daripada perempuan pada karakteristik lain yang sama. |
| konstanta | 12,36266 | 0,06068 | 0,000 | Prediksi ln-pendapatan perempuan di desa dengan 0 tahun sekolah dan 0 pengalaman, setara ≈ Rp233.900 per bulan. Nilai ini hanya titik acuan, bukan temuan substantif. |

### Efek pengalaman (efek marjinal)

Karena ada suku kuadrat, efek satu tahun pengalaman tambahan bergantung pada tingkat pengalaman:

```
∂ln(Y)/∂experience = β2 + 2·β3·experience = 0,0195909 − 0,000744·experience
```

| Tingkat pengalaman | Efek 1 tahun tambahan |
|---|---|
| 0 tahun | +1,96% |
| 10 tahun | +1,22% |
| 20,4 tahun (rata-rata sampel) | +0,44% |
| 26 tahun | ≈ 0% (puncak) |
| 40 tahun | −1,02% |

**Titik puncak** pendapatan: `experience* = −β2 / (2·β3)`

| Model | Puncak (tahun pengalaman) |
|---|---|
| Full | 26,3 |
| Urban | 25,5 |
| Rural | 28,0 |

Setelah titik ini, tambahan pengalaman berasosiasi dengan pendapatan yang menurun. Pada data ini hal itu juga mencerminkan efek kohor dan usia pekerja senior yang beralih ke pekerjaan paruh waktu atau informal, bukan hanya depresiasi keterampilan.

---

## 3. Interpretasi Model Split

### 3.1 Urban (n = 2.377, R² = 0,0462)

| Variabel | Koefisien | p-value | Interpretasi |
|---|---|---|---|
| schooling | 0,01452 | 0,001 | Return to education urban ≈ 1,45% per tahun sekolah. |
| experience | 0,01918 | 0,000 | Efek positif pada awal karier. |
| experience² | −0,0003756 | 0,000 | Kurva cekung, puncak ±25,5 tahun. |
| gender | 0,25650 | 0,000 | Laki-laki ≈ 25,6% (eksak 29,2%) lebih tinggi daripada perempuan di kota. |
| konstanta | 12,51309 | 0,000 | Baseline perempuan, 0 sekolah, 0 pengalaman ≈ Rp271.900. |

### 3.2 Rural (n = 1.612, R² = 0,0667)

| Variabel | Koefisien | p-value | Interpretasi |
|---|---|---|---|
| schooling | 0,01426 | 0,015 | Return to education rural ≈ 1,43% per tahun sekolah, signifikan pada 5%. |
| experience | 0,01946 | 0,000 | Efek positif pada awal karier. |
| experience² | −0,0003474 | 0,000 | Kurva cekung lebih landai, puncak ±28,0 tahun. |
| gender | 0,35840 | 0,000 | Laki-laki ≈ 35,8% (eksak 43,1%) lebih tinggi daripada perempuan di desa. |
| konstanta | 12,31548 | 0,000 | Baseline perempuan, 0 sekolah, 0 pengalaman ≈ Rp223.100. |

---

## 4. Perbandingan Urban vs Rural

Karena kedua subsampel saling lepas, selisih koefisien dapat diuji dengan uji z sederhana: `z = (β_urban − β_rural) / √(SE_urban² + SE_rural²)`. Ini aproksimasi; uji formal yang setara adalah model dengan interaksi (`urban##c.schooling`, `urban##gender`) atau uji Chow.

| Koefisien | Urban | Rural | Selisih | SE selisih | z | p (dua sisi) | Kesimpulan |
|---|---|---|---|---|---|---|---|
| schooling | 0,01452 | 0,01426 | 0,00026 | 0,00741 | 0,04 | ≈ 0,97 | Tidak berbeda secara statistik |
| gender | 0,25650 | 0,35840 | −0,10190 | 0,04909 | −2,08 | ≈ 0,038 | Berbeda signifikan pada 5% |

**Return to education:** selisih urban–rural (0,03 poin persentase) jauh lebih kecil daripada galat bakunya. Secara statistik tidak ada bukti bahwa return to education di kota lebih tinggi daripada di desa pada data *unadjusted wage*. Arah hipotesis H2 (urban > rural) terpenuhi secara angka, tetapi tidak signifikan.

**Kesenjangan gender:** laki-laki mendapat keunggulan upah yang lebih besar di desa daripada di kota. Selisihnya sekitar 10 poin log dan signifikan pada 5% (uji aproksimasi), sehingga mendukung H3 dengan kekuatan sedang, bukan "sangat meyakinkan". Tingkat kepercayaan 1% tidak tercapai.

---

## 5. Kecocokan Model

| Ukuran | Full | Urban | Rural |
|---|---|---|---|
| R-squared | 0,0578 | 0,0462 | 0,0667 |
| Root MSE | 0,7543 | 0,7546 | 0,7535 |
| F-statistik | F(5, 3983) = 48,90 | F(4, 2372) = 26,10 | F(4, 1607) = 32,18 |
| Prob > F | 0,0000 | 0,0000 | 0,0000 |

- Semua variabel secara bersama-sama signifikan (F-test), tetapi hanya sekitar 5–7% variasi ln-pendapatan yang dijelaskan. Ini lazim pada persamaan Mincer berbasis data survei individu, karena faktor seperti kemampuan, jaringan, sektor pekerjaan, dan jam kerja tidak masuk model.
- Root MSE ≈ 0,75 berarti prediksi model meleset sekitar 75 log points (kurang lebih satu kali lipat pendapatan) untuk individu tertentu. Model berguna untuk menaksir **rata-rata** hubungan, bukan memprediksi pendapatan individu.
- Standar deviasi `lnpendapatan` sampel (0,777) hampir sama dengan Root MSE, yang menunjukkan bahwa variabel-variabel model hanya sedikit mengurangi sebaran pendapatan.

---

## 6. Uji Asumsi

| Uji | Hasil | Interpretasi |
|---|---|---|
| VIF | experience 10,05 / 11,35; experience² 9,46 / 9,86 (Urban / Rural); schooling 1,56 / 1,92; gender 1,01 | VIF tinggi hanya pada pasangan experience–experience², yang bersifat struktural karena bentuk kuadratik. Tidak ada kolinearitas bermasalah pada variabel lain. |
| sktest (normalitas residual) | Adj χ²(2) = 856,79 (Urban), 837,52 (Rural); p = 0,0000 | Normalitas ditolak. Dengan n ribuan, inferensi OLS tetap sahih secara asimtotik (*CLT*). Skewness negatif pada ln-pendapatan sejalan dengan histogram. |
| Heteroskedastisitas | Ditangani dengan `vce(robust)` (White, 1980) | Standard error valid walaupun varians residual tidak konstan. |

Catatan teknis: pada output `sktest`, kolom `Obs` tertulis 3.989 untuk residual urban maupun rural, padahal subsampel berukuran 2.377 dan 1.612. Ini mengindikasikan bahwa variabel residual mungkin berisi nilai dari lebih dari satu regresi (mis. `predict` dijalankan setelah regresi lain). Sebaiknya dicek ulang di Stata (`summarize resid_urban resid_rural` atau `count if !missing(resid_urban)`) sebelum angka 856,79 dan 837,52 dikutip.

---

## 7. Kaitan dengan Hipotesis

| Hipotesis | Bunyi | Status | Dasar |
|---|---|---|---|
| H1 | Pendidikan dan pengalaman berpengaruh positif; pengalaman non-linear | **Diterima** | β schooling > 0 (p < 0,01); β experience > 0 dan β experience² < 0 (p < 0,01); puncak pada 25–28 tahun |
| H2 | Return to education urban > rural | **Diterima secara arah saja** | 1,45% vs 1,43%; selisih tidak signifikan (z = 0,04) |
| H3 | Gender wage gap rural > urban | **Diterima, dukungan sedang** | 35,8% vs 25,6%; selisih signifikan pada 5% (z ≈ −2,08), tidak pada 1% |

---

## 8. Perbandingan dengan Yubilianto (2020)

| | Penelitian ini | Yubilianto (2020), Tabel 8, kolom Mincerian |
|---|---|---|
| Return to education Urban | 1,45% | 8,9% |
| Return to education Rural | 1,43% | 7,7% |
| Selisih Urban – Rural | 0,02 poin | 1,2 poin |
| Upah | Pendapatan bulanan riil tanpa penyesuaian | Disesuaikan ke setara pekerja penuh waktu (8 jam/hari, 22 hari/bulan) |
| Sampel | Termasuk semua pekerja berpendapatan | Pegawai pemerintah dikeluarkan |

Penjelasan yang diajukan naskah: pendapatan bulanan tanpa penyesuaian bercampur dengan variasi jam kerja dan intensitas kerja pekerja informal dan paruh waktu. Variasi itu tidak berkaitan dengan pendidikan, sehingga koefisien pendidikan teredam (*attenuated*) dibanding data yang sudah distandardisasi.

Ini penjelasan yang masuk akal, tetapi **belum diuji** pada data ini karena variabel jam kerja tidak ada di model. Untuk menguatkannya, penelitian lanjutan dapat (a) menambahkan jam kerja sebagai kontrol, (b) mengestimasi ulang pada subsampel pekerja penuh waktu, atau (c) mengestimasi ulang dengan upah per jam. Bila koefisien schooling naik mendekati 7–9%, klaim naskah terbukti. Perbedaan pengecualian PNS dan perbedaan jumlah observasi juga bisa ikut berkontribusi.

---

## 9. Batas Interpretasi

1. **Asosiasi, bukan kausalitas.** Koefisien `schooling` memuat efek kemampuan bawaan, latar belakang keluarga, dan faktor tak teramati lain yang berkorelasi dengan lama sekolah (*omitted variable bias*). Return to education ini bukan efek kausal pendidikan.
2. **Seleksi sampel.** Hanya pekerja yang melaporkan pendapatan yang masuk sampel. Bila partisipasi kerja perempuan dan keputusan bekerja berbeda antara kota dan desa, estimasi gender gap dapat terdistorsi (bias seleksi, seperti dalam kerangka Heckman).
3. **Gender gap tidak terkondisi pada okupasi dan jam kerja.** Koefisien `gender` adalah selisih rata-rata setelah mengontrol pendidikan dan pengalaman saja. Selisih yang berasal dari perbedaan jam kerja, sektor, atau okupasi ikut terhitung. Karena itu istilah "diskriminasi" pada naskah merupakan kerangka tafsir teoretis (Becker, 1971; Blau & Kahn, 2017), bukan sesuatu yang diuji langsung oleh model ini.
4. **Pengalaman potensial.** `experience = umur − sekolah − 6` bukan pengalaman kerja aktual; pada perempuan yang berhenti bekerja untuk pengasuhan, pengalaman potensial melebihi pengalaman aktual. Nilai −2 pada minimum menunjukkan responden yang lulus lebih lambat dari asumsi usia mulai sekolah.
5. **Pelaporan pendapatan.** Histogram `lnpendapatan` menunjukkan penumpukan pada nilai tertentu (pembulatan nominal), sehingga distribusi miring ke kiri dan tidak mendekati normal.
6. **Perbandingan antar-model.** Koefisien split sample diestimasi pada sampel berbeda; selisihnya hanya sahih bila model yang sama berlaku pada kedua kelompok. Uji interaksi lebih tegas untuk membuktikan perbedaan struktural.

---

## 10. Ringkasan Satu Paragraf

Pendidikan dan pengalaman berasosiasi positif dengan pendapatan, dan pengalaman membentuk kurva cekung dengan puncak sekitar 25–28 tahun. Return to education pada pendapatan bulanan tanpa penyesuaian hanya sekitar 1,4% per tahun sekolah dan hampir identik antara kota (1,45%) dan desa (1,43%), jauh di bawah temuan Yubilianto (2020) sebesar 8,9% dan 7,7% pada upah yang distandardisasi. Pekerja kota berpendapatan sekitar 13% lebih tinggi daripada pekerja desa pada karakteristik yang sama. Keunggulan upah laki-laki atas perempuan jauh lebih besar di desa (≈ 36% menurut aproksimasi, ≈ 43% menurut konversi eksak) daripada di kota (≈ 26%, ≈ 29%), dan selisih ini signifikan pada 5%. Seluruh hasil bersifat asosiatif, dengan daya jelas model rendah (R² 5–7%).
