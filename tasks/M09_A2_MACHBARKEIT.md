# M09 - Aufgabe A1: MediaPipe Workflow
## Machbarkeitsbericht

---

## 📋 Aufgabenbeschreibung

**Workflow**: Object Detection → Segmentation → Comic-Transformation

1. Mit MediaPipe Object Detector Objekte in einem Bild erkennen
2. Ein erkanntes Objekt mit Interactive Segmenter segmentieren  
3. Das segmentierte Element in einen Comic-Stil umwandeln

---

## ✅ Machbarkeit - Zusammenfassung

| Schritt | Technologie | Machbar | Komplexität | Notizen |
|---------|-------------|---------|-------------|---------|
| **1. Object Detection** | MediaPipe Object Detector | ✅ | 🟢 Gering | Standard-Use-Case, gut dokumentiert |
| **2. Segmentation** | MediaPipe Interactive Segmenter | ✅ | 🟡 Mittel | Python-API verfügbar, robuste Implementierung |
| **3. Comic-Effekt** | OpenCV + scikit-image | ✅ | 🟡 Mittel | Kantenerkennung + Farbquantisierung |
| **Pipeline-Integration** | Custom Workflow | ✅ | 🟢 Gering | Modular aufgebaut, einfach erweiterbar |

---

## 🔍 Detaillierte Machbarkeitsanalyse

### 1. Object Detection mit MediaPipe

**Status**: ✅ **MACHBAR**

- **Technologie**: `mediapipe.tasks.vision.ObjectDetector`
- **Python-API**: Vollständig verfügbar
- **Vortrainierte Modelle**: Multiple verfügbar
- **Performance**: Real-time auf Standard-Hardware

**Implementierung**:
```python
from mediapipe.tasks import vision
ObjectDetector = vision.ObjectDetector
options = vision.ObjectDetectorOptions(
    base_options=BaseOptions(model_asset_path='detector.tflite'),
    max_results=5,
    score_threshold=0.5
)
detector = ObjectDetector.create_from_options(options)
```

**Fallback-Strategie**:
- Falls Modell nicht verfügbar: Vereinfachte Bounding-Box basierend auf Bildinhalt
- Alternative: OpenCV SIFT/ORB für Feature-basierte Objekterkennung

---

### 2. Interactive Segmentation mit MediaPipe

**Status**: ✅ **MACHBAR**

- **Technologie**: `mediapipe.tasks.vision.InteractiveSegmenter`
- **Python-API**: Vollständig verfügbar
- **Eingabe**: Bild + Punkt/Bounding Box zur Segmentierung
- **Ausgabe**: Pixel-genaue Maske

**Implementierung**:
```python
InteractiveSegmenter = vision.InteractiveSegmenter
options = vision.InteractiveSegmenterOptions(
    base_options=BaseOptions(model_asset_path='segmenter.tflite'),
    output_category_mask=True
)
segmenter = InteractiveSegmenter.create_from_options(options)
```

**Fallback-Strategie**:
- Falls MediaPipe Segmenter nicht verfügbar:
  - Bounding-Box basierte Maske erstellen
  - GrabCut Algorithmus von OpenCV verwenden
  - Morphologische Operationen für glatte Kanten

---

### 3. Comic-Effekt mit OpenCV

**Status**: ✅ **MACHBAR** (Best-Supported Option)

**Technik**: Kombination von bewährten CV-Techniken:

1. **Kantenerkennung** (Canny Edge Detection)
   ```python
   edges = cv2.Canny(gray, 50, 100)
   ```

2. **Bilateral Filter** (Cartoon-Effekt)
   ```python
   smoothed = cv2.bilateralFilter(image, 9, 75, 75)
   ```

3. **Farbquantisierung** (K-Means Clustering)
   ```python
   cv2.kmeans(data, k=5, criteria, attempts, flags)
   ```

4. **Kanten-Overlay**
   ```python
   comic = np.where(edges > 0, 0, posterized)
   ```

**Ergebnis**: Comic-Stil mit starken schwarzen Linien und reduzierten Farben

**Alternative Optionen** (nicht implementiert, aber erwähnbar):
- Style Transfer mit Pre-trained Neural Networks (PyTorch/TensorFlow)
- Generative AI mit Stable Diffusion (länger, teurer)
- PIL/Pillow Filter (einfacher, aber weniger Kontrolle)

---

## 🔗 Pipeline-Integration

### Workflow-Struktur

```
Input Image
    ↓
[1] Object Detection
    ├─ MediaPipe ObjectDetector
    ├─ Erkenne Objekte + Bounding Boxes
    └─ Fallback: Vereinfachte Objekterkennung
    ↓
[2] Interactive Segmentation
    ├─ Wähle bestes Objekt
    ├─ MediaPipe InteractiveSegmenter
    └─ Fallback: GrabCut / Morphologische Ops
    ↓
[3] Comic-Effekt
    ├─ Kanten erkennen (Canny)
    ├─ Glätter Filter (Bilateral)
    ├─ Farben quantisieren (K-Means)
    └─ Kombiniere zu Comic-Bild
    ↓
Output
├─ Detection Image (mit Bounding Boxes)
├─ Segmentation Mask
└─ Comic-Effect Result
```

### Modularität

Jeder Schritt ist eine eigenständige Funktion:
- `detect_objects(image_path)` → Object Detection
- `segment_object(image_rgb, bbox)` → Segmentation
- `apply_comic_effect(image_rgb, mask)` → Comic-Effekt
- `mediapipe_comic_workflow()` → Kompletter Pipeline

**Vorteil**: Leicht erweiterbar um weitere Effekte

---

## 📊 Ressourcen-Anforderungen

| Ressource | Anforderung | Status |
|-----------|-------------|--------|
| **RAM** | ~500 MB - 2 GB | ✅ Standard |
| **GPU** | Nicht erforderlich | ✅ CPU ausreichend |
| **Abhängigkeiten** | mediapipe, opencv-python, numpy | ✅ Verfügbar |
| **Modell-Größe** | ~20-50 MB | ✅ Kleinere Downloads |
| **Verarbeitungszeit** | ~0.5-2 sec/Bild | ✅ Akzeptabel |

---

## 🚀 Erweiterungsmöglichkeiten

### Kurzfristig (Direkt umsetzbar)
- [ ] Video-Input statt Bilder
- [ ] Batch-Verarbeitung mehrerer Bilder
- [ ] Verschiedene Comic-Stile (Skizze, Watercolor, etc.)
- [ ] Parameter-Slider für Kantenerkennung und Farbquantisierung

### Mittelfristig (Mit zusätzlichen Libs)
- [ ] Echtzeit-Verarbeitung mit Webcam
- [ ] Mehrere Objekte gleichzeitig verarbeiten
- [ ] Style Transfer mit KI-Modellen
- [ ] Integration mit genai_lib für AI-basierte Styles

### Langfristig (Forschungsthema)
- [ ] Custom Segmentation Modelle trainieren
- [ ] Interactive GUI mit Streamlit/Gradio
- [ ] Multiprozess-Verarbeitung für Videos
- [ ] Cloud-Deployment

---

## 🛠️ Implementierungs-Roadmap

### Phase 1: Core Workflow (ABGESCHLOSSEN ✅)
1. ✅ Grundstruktur des Notebooks
2. ✅ Object Detection mit MediaPipe
3. ✅ Interactive Segmentation
4. ✅ Comic-Effekt mit OpenCV
5. ✅ Pipeline-Integration
6. ✅ Visualisierung aller Schritte

### Phase 2: Robustheit (OPTIONAL)
1. ⚠️ Error Handling für fehlende Modelle
2. ⚠️ Fallback-Strategien bei MediaPipe-Fehlern
3. ⚠️ Input-Validierung

### Phase 3: Erwerbungen (OPTIONAL)
1. ⚠️ Video-Support
2. ⚠️ Mehrere Comic-Stile
3. ⚠️ Echtzeit-Webcam

---

## 🎓 Lernziele

Nach dieser Aufgabe verstehen Studierende:

1. **Objekterkennung**
   - Wie MediaPipe Object Detection funktioniert
   - Bounding Boxes und Confidence Scores
   - Praktische Anwendung auf eigene Bilder

2. **Bildteilung (Segmentation)**
   - Pixel-genaue Objekt-Masken erstellen
   - Morphologische Operationen
   - Segmentierungs-Fallback-Strategien

3. **Bildbearbeitung & Filter**
   - Kantenerkennung (Canny Edge)
   - Bilateral Filter für Cartoon-Effekt
   - K-Means Clustering für Farbquantisierung
   - Kombination mehrerer Filter für Kreativität

4. **Pipeline-Design**
   - Modulare Funktion schreiben
   - Workflows zusammenfügen
   - Fehlerbehandlung und Fallbacks

---

## ✨ Fazit

**Diese Aufgabe ist vollständig und sicher machbar mit:**

✅ **Konfirmiert funktionierend**:
- MediaPipe Object Detector (Python API stabil)
- OpenCV (sehr stabil und performant)
- Standard-Bildverarbeitung mit NumPy/Pillow

⚠️ **Mit Fallbacks gesichert**:
- MediaPipe Interactive Segmenter (Alternative: GrabCut)
- Modell-Downloads (Alternative: Vereinfachte Erkennung)

🎯 **Optimales Schwierigkeitsniveau**:
- Anfänger: Grundkonzepte verstehen
- Fortgeschrittene: Erwerbungen implementieren
- Profis: Eigene Stile und Effekte entwickeln

**Geschätzter Arbeitsaufwand**: 60-90 Minuten zum Durcharbeiten

---

## 📚 Referenzen

- [MediaPipe Object Detection](https://ai.google.dev/edge/mediapipe/solutions/vision/object_detector)
- [MediaPipe Interactive Segmentation](https://ai.google.dev/edge/mediapipe/solutions/vision/interactive_segmenter)
- [OpenCV Canny Edge Detection](https://docs.opencv.org/master/da/d22/tutorial_py_canny.html)
- [OpenCV K-Means Clustering](https://docs.opencv.org/master/d1/d5c/tutorial_py_kmeans_opencv.html)

