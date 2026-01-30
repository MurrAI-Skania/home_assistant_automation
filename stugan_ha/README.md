# Stugan Home Assistant Logic

## 🌡️ Climate Control (AC)
A robust, layered climate system designed for safety, energy efficiency, and comfort.

### Architecture Layers
1.  **Emergency Layer (Frost Guard):**
    *   **Priority:** Highest. Overrides all other settings.
    *   **Trigger:** If *any* indoor sensor drops below **8.0°C** for 10 mins.
    *   **Action:** Force AC to **Heat 8°C**, Boost Off, Sleep Off.
    *   **Release:** When all sensors rise above **9.0°C**.

2.  **Season Layer (Heating Guard):**
    *   **Priority:** Second.
    *   **Trigger:** Controlled by `sensor.ac_outdoor_temperature`.
    *   **Off:** Outdoor > 10.5°C (30 min duration). AC turns **OFF**.
    *   **On:** Outdoor < 9.5°C (30 min duration). AC allowed to run.
    *   **Fail-Safe:** If outdoor sensor is `unknown/unavailable`, heating is enabled by default.

3.  **Policy Layer (House Modes):**
    *   **Hemma (Home):**
        *   **Schedule:** Day/Night targets.
        *   **Sleep Mode:** Enforced ON at night (22:00-06:15), OFF during day.
        *   **Boost:** Active on arrival or resume if room is **>3.0°C** below target.
    *   **Borta (Away):**
        *   **Target:** Keeps **coldest room** at safety temp (via `sensor.indoor_min_temperature`).
        *   **Profile:** Sleep Mode ON (Quiet/Low Fan).
    *   **På väg (On the Way):**
        *   **Boost:** Blasts heat until target reached.

### Core Components
*   **AC Unit:** `climate.sandras_ac` (Midea)
*   **Gate Script:** `script.ac_apply_state` - The single point of entry. 
    *   **Deduplication:** Prevents redundant commands based on real device state.
    *   **Pacing:** 3-5s delays between commands to protect hardware.
    *   **Display Control:** Automatically turns off `switch.sandras_ac_screen_display` after any adjustment.

---

## 💡 Lighting & Buttons
Logic for Zigbee smart switches controlling three specific zones.

### Common Interaction Pattern
*   **Button 1 Short:** Turn ON (Low/20%) or Step Up Brightness.
*   **Button 1 Long:** **MAX** Mode (100% Brightness + Cold White).
*   **Button 2 Short:** Turn OFF (if dim) or Step Down Brightness.
*   **Button 2 Long:** **MYS** (Cozy) Mode (Dim + Warm White) or Cycle Scenes.

---

## 🔒 Security & System
*   **Cameras:** Two-way sync between `input_boolean.camera_privacy` and `switch.stugan_cameras` with loop guards.
*   **Debouncing:** 2-second delay on slider inputs.
*   **Restarts:** State refreshes immediately on startup.
