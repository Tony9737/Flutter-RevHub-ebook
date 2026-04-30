# flutter_hw3_car_collection

一個以汽車展示廳為主題的 Flutter 專案。啟動後會先顯示介紹頁，點擊畫面即可進入展示廳，瀏覽車輛卡片、詳細資訊、圖片集與音效內容。

## 專案特色

- 車輛資料集中管理在 [lib/vehicle_data.dart](lib/vehicle_data.dart)，目前使用 mockVehicles 作為展示資料來源。
- 每台車都有品牌、型號、描述、價格、規格、媒體資源與評分資訊。
- 展示廳支援收藏功能，收藏狀態會以車輛品牌與型號作為識別鍵。
- 內建國家篩選、隨機展示與收藏清單頁籤。
- 部分車輛包含封面圖、細節圖與音效檔，可在詳情頁中瀏覽。
- 專案啟動時會先播放背景音樂。

## 畫面流程

1. 進入介紹頁。
2. 點擊畫面後切換到展示廳。
3. 在展示廳中瀏覽車輛、篩選國家、加入收藏。
4. 點進車輛後查看圖片、資料與相關媒體。

## 專案結構

- [lib/main.dart](lib/main.dart)：App 入口、主題設定與介紹頁。
- [lib/show_room_page.dart](lib/show_room_page.dart)：展示廳主畫面與收藏、篩選邏輯。
- [lib/vehicle.dart](lib/vehicle.dart)：車輛資料模型。
- [lib/vehicle_data.dart](lib/vehicle_data.dart)：車輛 mock 資料。
- [lib/preview_page.dart](lib/preview_page.dart)：車輛預覽與篩選頁。
- [lib/vehicle_card.dart](lib/vehicle_card.dart)：車輛卡片元件。
- [lib/vehicle_intro_page.dart](lib/vehicle_intro_page.dart)：介紹相關頁面。
- [lib/audio_manager.dart](lib/audio_manager.dart)：背景音樂與音效管理。

## 執行方式

1. 安裝依賴：

```bash
flutter pub get
```

2. 執行專案：

```bash
flutter run
```

如果你要指定平台，也可以使用：

```bash
flutter run -d chrome
flutter run -d windows
flutter run -d android
```

## 資源說明

- 圖片、音檔與字型都放在 [assets/](assets/) 下。
- 車輛封面與細節圖會依照媒體資料中的路徑載入。
- 專案使用自訂字型 AppFont，定義在 [pubspec.yaml](pubspec.yaml)。

## 開發備註

- 車輛媒體路徑會依 `coverPath` 組合，例如 `images/cover/cover.jpg` 與 `images/detail/p{n}.jpg`。
- 收藏功能使用 `vehicleFavoriteKey(vehicle)` 作為唯一鍵。
- 若要新增車輛，建議先補齊 [lib/vehicle_data.dart](lib/vehicle_data.dart) 中的資料，再確認對應的資源檔案已放入 `assets/` 並在 [pubspec.yaml](pubspec.yaml) 中註冊。

## Flutter 文件

如果你是第一次使用 Flutter，可以參考官方文件：

- [Flutter getting started](https://docs.flutter.dev/get-started/install)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter documentation](https://docs.flutter.dev/)
