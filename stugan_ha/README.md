# Stugan Home Assistant Logic

## 🌡️ Climate Control (AC)
A robust, layered climate system designed for safety, energy efficiency, and comfort.

### Architecture Layers
1.  **Emergency Layer (Frost Guard):**
    *   **Priority:** Highest. Overrides all other settings.
    *   **Trigger:** If *any* indoor sensor (`sensor.indoor_min_temperature`) drops below **8.0°C** for 10 mins.
    *   **Action:** Force AC to **Heat 8°C**, Boost Off, Sleep Off.
    *   **Release:** When all sensors rise above **9.0°C**.

2.  **Season Layer (Heating Guard):**
    *   **Priority:** Second.
    *   **Trigger:** Controlled by `sensor.ac_outdoor_temperature`.
    *   **Off:** Outdoor > 10.5°C (30 min duration). AC turns **OFF**.
    *   **On:** Outdoor < 9.5°C (30 min duration). AC allowed to run.

3.  **Policy Layer (House Modes):**
    *   **Hemma (Home):**
        *   **Schedule:** Day/Night targets.
        *   **Sleep Mode:** Enforced ON at night (22:00-06:15), OFF during day.
        *   **Boost:** Active on arrival if room is cold.
    *   **Borta (Away):**
        *   **Target:** Keeps **coldest room** at safety temp (e.g., 8°C).
        *   **Profile:** Sleep Mode ON (Quiet/Low Fan).
    *   **På väg (On the Way):**
        *   **Target:** User-defined arrival temp.
        *   **Boost:** Blasts heat until target reached.

### Core Components
*   **AC Unit:** `climate.sandras_ac` (Midea)
*   **Gate Script:** `script.ac_apply_state` - The single point of entry. Handles deduplication, pacing (3-5s delays), and state persistence.
*   **Regulator:** `script.temp_reglerare...` - P-Controller for precise temperature holding.

---

## 💡 Lighting & Buttons
Logic for Zigbee smart switches controlling three specific zones.

### Common Interaction Pattern
*   **Button 1 Short:** Turn ON (Low/20%) or Step Up Brightness.
*   **Button 1 Long:** **MAX** Mode (100% Brightness + Cold White).
*   **Button 2 Short:** Turn OFF (if dim) or Step Down Brightness.
*   **Button 2 Long:** **MYS** (Cozy) Mode (Dim + Warm White) or Cycle Scenes.

### Zones
*   **Living Room:** `light.vardagsrum_lampor` + LED Strip (Color themes).
*   **Bedroom:** `light.sovrum_taklampa` + Corner Lamp.
*   **Murre's Room:** `light.murres_lampor`.

---

## 🔒 Security & System
*   **Cameras:** `input_boolean.camera_privacy` syncs directly with `switch.stugan_cameras` (Turn on privacy -> Turn on switch).
*   **Debouncing:** Slider inputs have a 2-second delay.
*   **Restarts:** System state refreshes immediately upon Home Assistant restart.