# Stugan HA: Entity Registry

This registry tracks all physical devices, helpers, and scripts used in the project.

---

## 🌡️ Climate Control (AC)

### Physical Devices & Sensors
| Entity ID | Friendly Name | Role |
| :--- | :--- | :--- |
| `climate.sandras_ac` | Sandra's AC | Main heating/cooling unit (Midea) |
| `sensor.vardagsrum_kallax_temperature` | Living Room Temp | Primary sensor for Hemma logic |
| `sensor.indoor_min_temperature` | Min Temp | Tracks lowest indoor temp for Frost Guard & Borta |
| `sensor.ac_outdoor_temperature` | Outdoor Temp | Controls Global Heating Guard |
| `switch.ac_sleep_mode` | AC Sleep Mode | Toggles hardware Sleep function |
| `switch.boost_mode` | AC Boost Mode | Toggles hardware Boost function |
| `switch.sandras_ac_screen_display` | AC Screen Display | Controlled by Gate to hide display light |

### Logic Helpers
| Entity ID | Type | Description |
| :--- | :--- | :--- |
| `input_select.huslage` | Select | Current mode: `Hemma`, `Borta`, `På_väg` |
| `input_boolean.heating_enabled` | Boolean | **Global Guard:** ON if cold outside or sensor unknown |
| `input_boolean.frost_guard_active` | Boolean | **Emergency:** ON if indoor temp < 8°C |
| `input_number.hemma_borvarde_dag` | Number | Target temperature during the day (Home) |
| `input_number.hemma_borvarde_natt` | Number | Target temperature during the night (Home) |
| `input_number.pa_vag_target` | Number | Desired temperature upon arrival |
| `input_number.borta_sovrum_target` | Number | Minimum safety temperature when away |
| `input_boolean.ac_smart_regulation` | Boolean | Enable/Disable P-Controller logic |
| `input_text.ac_last_state_json` | Text | Persists desired state for deduplication |
| `timer.ac_command_cooldown` | Timer | 30s gap between physical AC commands |
| `timer.huslage_cooldown` | Timer | 20s debounce for House Mode changes |

---

## 💡 Lighting & Buttons

### Vardagsrum (Living Room)
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `light.vardagsrum_lampor` | Group | All main lights in living room |
| `light.vardagsrum_taklampa` | Light | Main ceiling light |
| `light.vardagsrum_ledstrip_baksida` | Light | LED strip on the back of furniture |
| `event.vardagsrum_knapp_entre_button_1` | Event | Physical button (Top) |
| `event.vardagsrum_knapp_entre_button_2` | Event | Physical button (Bottom) |
| `input_select.vardagsrum_led_mysbelysning_cykel` | Select | Cycles themes: Gold, Red, Purple, etc. |

### Sovrum (Bedroom)
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `light.sovrum_taklampa` | Light | Main bedroom light |
| `light.murres_golvlampa_horn` | Light | Floor lamp in the corner |

---

## ⚙️ Core Scripts (The "APIs")

| Script ID | Name | Role |
| :--- | :--- | :--- |
| `script.ac_apply_state` | AC Gate | **Crucial:** Single entry point. Manages Sleep, Boost, Temp, Mode, Display. |
| `script.temp_reglerare_1_steg_1_c_via_gate` | Regulator | P-Controller for maintenance. 0.5°C deadband. |
