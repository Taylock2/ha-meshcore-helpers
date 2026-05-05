# MeshCore Home Assistant Blueprints

A collection of utility blueprints for managing and automating [MeshCore](https://github.com/meshcore) nodes within Home Assistant.

## Blueprints

### 📍 Location Fuzzer
This blueprint automatically updates a MeshCore node's location within a defined radius. It is designed for users who want to maintain privacy for static nodes (like home-based repeaters) or simulate movement for testing.

**Features:**
* **Custom Radius:** Define a fuzzing zone between 50m and 1000m.
* **Weighted Math:** Uses latitude/longitude scaling to maintain a circular fuzzing area.
* **Scheduled Updates:** Choose your own refresh interval via the UI.

#### How to Import
[![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https://github.com/Taylock2/ha-meshcore-helpers/blob/main/blueprints/automation/Taylock2/meshcore_fuzzer.yaml)

---

## Installation
1. Ensure you have the `meshcore` integration configured in Home Assistant.
2. Click the **Import** button above or copy the URL of the YAML file.
3. In Home Assistant, go to **Settings > Automations > Blueprints > Import Blueprint**.
4. Create a new automation using the blueprint and select your target node and base location.