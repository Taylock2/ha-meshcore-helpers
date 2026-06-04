# MeshCore Home Assistant Add-ons & Blueprints

A collection of utility add-ons and blueprints for managing and automating [MeshCore](https://meshcore.io/) nodes within Home Assistant.

---

## 📦 Home Assistant Add-ons

### 🖥️ Meshcore RemoteTerm
A backend server and web-based terminal interface for MeshCore mesh radio networks. It enables browser-based interactive communication with your MeshCore nodes via Serial or TCP connection.

#### How to Install
1. In Home Assistant, navigate to **Settings > Add-ons > Add-on Store**.
2. Click the menu button (three vertical dots) in the top-right corner and select **Repositories**.
3. Add the following repository URL:
   ```
   https://github.com/Taylock2/ha-meshcore-helpers
   ```
4. Find **Meshcore RemoteTerm** in the list, click it, and select **Install**.
5. Configure the add-on settings (Connection type, Port, Credentials) under the Configuration tab and start the add-on.

---

## 📜 Blueprints

### 📍 Location Fuzzer
This blueprint automatically updates a MeshCore node's location within a defined radius. It is designed for users who want to maintain privacy for static nodes (like home-based repeaters) or simulate movement for testing.

**Features:**
* **Custom Radius:** Define a fuzzing zone between 50m and 1000m.
* **Weighted Math:** Uses latitude/longitude scaling to maintain a circular fuzzing area.
* **Scheduled Updates:** Choose your own refresh interval via the UI.

#### How to Import
[![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https://raw.githubusercontent.com/Taylock2/ha-meshcore-helpers/refs/heads/main/blueprints/automation/Taylock2/meshcore_fuzzer_blueprint.yaml)

#### How to Use
1. Ensure you have the `meshcore-ha` integration configured in Home Assistant.
2. Click the **Import** button above or copy the URL of the YAML file.
3. In Home Assistant, go to **Settings > Automations > Blueprints > Import Blueprint**.
4. Create a new automation using the blueprint and select your target node and base location.
