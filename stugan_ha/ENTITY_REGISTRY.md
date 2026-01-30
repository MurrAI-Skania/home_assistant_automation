# Stugan HA: Entity Registry

This registry tracks all physical devices, helpers, and scripts used in the project. Use this as a reference when updating automations or replacing hardware.

---

## 🌡️ Climate Control (AC)

### Physical Devices & Sensors
| Entity ID | Friendly Name | Role |
| :--- | :--- | :--- |
| `climate.sandras_ac` | Sandra's AC | Main heating/cooling unit (Midea) |
| `sensor.vardagsrum_kallax_temperature` | Living Room Temp | Primary sensor for Hemma & På väg logic |
| `sensor.sovrum_temperatur` | Bedroom Temp | Primary sensor for Borta logic |
| `switch.ac_eco_mode` | AC Eco Mode | Toggles the hardware Eco function |
| `switch.boost_mode` | AC Boost Mode | Toggles hardware high-performance mode |

### Logic Helpers
| Entity ID | Type | Description |
| :--- | :--- | :--- |
| `input_select.huslage` | Select | Current mode: `Hemma`, `Borta`, `På_väg` |
| `input_number.hemma_borvarde_dag` | Number | Target temperature during the day (Home) |
| `input_number.hemma_borvarde_natt` | Number | Target temperature during the night (Home) |
| `input_number.pa_vag_target` | Number | Desired temperature upon arrival |
| `input_number.borta_sovrum_target` | Number | Minimum safety temperature when away |
| `input_boolean.ac_smart_regulation` | Boolean | Enable/Disable P-Controller logic |
| `input_text.ac_last_state_json` | Text | Persists desired state for deduplication |
| `timer.ac_command_cooldown` | Timer | 20s gap between physical AC commands |
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
| `input_boolean.vardagsrum_in_the_mood` | Boolean | Activates romantic/mood lighting loop |
| `input_boolean.vardagsrum_warning_emotionally_instable` | Boolean | Activates police/emergency light effect |

### Sovrum (Bedroom)
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `light.sovrum_taklampa` | Light | Main bedroom light |
| `light.murres_golvlampa_horn` | Light | Floor lamp in the corner |
| `event.sovrum_knapp_dorr_button_1` | Event | Physical button (Top) |
| `event.sovrum_knapp_dorr_button_2` | Event | Physical button (Bottom) |

### Murres Rum
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `light.murres_lampor` | Group | All lights in Murre's room |
| `event.murres_knapp_dorr_button_1` | Event | Physical button (Top) |
| `event.murres_knapp_dorr_button_2` | Event | Physical button (Bottom) |

---

## 🔒 Security & System

### Cameras
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `switch.stugan_cameras` | Switch | Physical power/control for cameras |
| `input_boolean.camera_privacy` | Boolean | UI Toggle for privacy (Syncs with switch) |

### Location
| Entity ID | Type | Role |
| :--- | :--- | :--- |
| `zone.home` | Zone | Used for auto-detecting Hemma/Borta |

---

## ⚙️ Core Scripts (The "APIs")

| Script ID | Name | Role |
| :--- | :--- | :--- |
| `script.ac_apply_state` | AC Gate | **Crucial:** Single entry point for all AC changes |
| `script.temp_reglerare_1_steg_1_c_via_gate` | Regulator | Calculates P-Offset for temperature maintenance |
| `script.vardagsrum_mys_loop` | Mood Loop | Handles the slow color transitions for mood light |
| `script.vardagsrum_save_led_strip_previous_state` | Snapshot | Saves current LED state before mood effects |
| `script.vardagsrum_restore_led_strip_previous_state` | Restore | Reverts LED to snapshot state |
