# Stugan Home Assistant Logic

## 🌡️ Climate Control (AC)
A custom "Smart Thermostat" logic built around **House Modes** (`input_select.huslage`) and a **Smart Regulator** (P-Controller).

### Core Components
*   **AC Unit:** `climate.sandras_ac` (Midea)
*   **Main Sensor:** `sensor.vardagsrum_kallax_temperature` (Hemma/På väg)
*   **Away Sensor:** `sensor.sovrum_temperatur` (Borta)
*   **Gate Script:** `script.ac_apply_state` - The single point of entry for AC commands. Handles:
    *   **Deduplication:** Checks real device state to prevent redundant commands.
    *   **Pacing:** Adds delays between Temp/Boost/Eco commands to prevent overwhelming the unit.
    *   **Logging:** Writes clear decision logs to the Logbook.

### Policies (Modes)
1.  **Hemma (Home)**
    *   **Schedule:** Day (06:15-20:00/22:00) vs Night targets.
    *   **Logic:** 
        *   **Arrival:** Triggers aggressive "Boost" (Heat+Fan Max) if room is significantly cold.
        *   **Maintenance:** Checks every 10 mins OR on temp change. Uses P-Regulation to hold target.
        *   **Eco Enforcement:** Forces `eco: true` whenever in normal regulation.
    *   **Safety:** 30s debounce on temp sensor to prevent jitter.

2.  **Borta (Away)**
    *   **Target:** Low static temp (e.g., 8°C or 16°C min).
    *   **Logic:**
        *   **Departure:** Immediately snaps AC to **16°C**, **Eco ON**, **Privacy OFF**.
        *   **Maintenance:** Periodically regulates bedroom temp towards target, always enforcing Eco.

3.  **På väg (On the Way)**
    *   **Target:** User-defined "Arrival" target (e.g., 21°C).
    *   **Logic:**
        *   **Boost:** Blasts heat until `Room Temp >= Target`.
        *   **Maintenance:** Once target reached, switches to normal regulation (Eco ON).

---

## 💡 Lighting & Buttons
Logic for Zigbee smart switches controlling three specific zones.

### Common Interaction Pattern
*   **Button 1 Short:** Turn ON (Low/20%) or Step Up Brightness.
*   **Button 1 Long:** **MAX** Mode (100% Brightness + Cold White).
*   **Button 2 Short:** Turn OFF (if dim) or Step Down Brightness.
*   **Button 2 Long:** **MYS** (Cozy) Mode (Dim + Warm White) or Cycle Scenes.

### Zones
*   **Living Room:** `light.vardagsrum_lampor` + LED Strip.
    *   *Special:* Cycle color themes (Gold, Red, Purple, etc.) via `input_select.mysbelysning_cykel`.
*   **Bedroom:** `light.sovrum_taklampa` + Corner Lamp.
*   **Murre's Room:** `light.murres_lampor`.

---

## 🔒 Security & Misc
*   **Cameras:** `input_boolean.camera_privacy` syncs directly with `switch.stugan_cameras` (Turn on privacy -> Turn on switch).
*   **Debouncing:** Slider inputs (temperature targets) have a 2-second delay before triggering logic.
*   **Restarts:** System state (AC Logic) refreshes immediately upon Home Assistant restart.
