# National Hospital Data Lake ETL Pipeline

![Hospital Data Lake Banner](https://about-britain.com/photos2/hospital-uk.jpg)

Welcome to the **National Hospital Data Lake ETL Pipeline** repository! This repo contains a Databricks notebook for orchestrating the ingestion, cleaning, and transformation of multi-source hospital data into Azure Data Lake Storage, ready for analytics and downstream processing.

---

## 📖 Overview

This project demonstrates how to build an end-to-end ETL workflow for a hospital environment, covering:

- **Mounting Azure Data Lake Storage** securely in Databricks.
- **Ingesting raw CSV data** from various domains (patients, labs, imaging, trials, etc.).
- **Cleaning, deduplicating, and transforming** each dataset for analytics use.
- **Writing processed data** back to storage in an organized structure.
- **Unmounting storage** for security and resource management.

All logic is implemented in Python using PySpark within a Databricks notebook.

---

## 📊 Data Flow Architecture

![ETL Pipeline Architecture](https://github.com/dibanga2800/nationalHospital/raw/main/assets/etl_architecture.png)

<details>
<summary>Click to enlarge diagram description</summary>
The pipeline starts by mounting an Azure Data Lake container, reads multiple hospital-related CSVs, applies cleaning and deduplication, adds a load timestamp, and writes processed data to dedicated folders. Finally, the storage is unmounted.
</details>

---

## 🚀 Quickstart

1. **Clone the repo**  
   ```bash
   git clone https://github.com/dibanga2800/nationalHospital.git
   ```

2. **Open `NathospNotebook.ipynb`** in your Databricks workspace.

3. **Set up Secrets**
   - Store your Azure Data Lake access key in Databricks Secrets (`scope="datalakekey"`, `key="datalakekey"`).

4. **Run the notebook cells** in order to:
   - Mount the storage account.
   - Ingest & process raw hospital data.
   - Write cleaned data to `/processed_data`.
   - Unmount the storage.

---

## 🏥 Data Domains

The pipeline processes the following datasets:

| Domain              | Path                                   | Description                   |
|---------------------|----------------------------------------|-------------------------------|
| Patients            | `/raw/patients_data.csv`               | Patient demographics & info   |
| Lab Results         | `/raw/lab_results_data.csv`            | Lab test results              |
| Imaging Results     | `/raw/imaging_results_data.csv`        | Radiology & imaging data      |
| Medical Records     | `/raw/medical_records_data.csv`        | Clinical medical records      |
| Clinical Trials     | `/raw/clinical_trials_data.csv`        | Hospital trial information    |
| Trial Participants  | `/raw/trial_participants_data.csv`     | Participants in trials        |

---
## 🧹 Data Cleaning Logic

- **Drop duplicates**
- **Remove null values**
- **Add `loaded_date` column**
- **Write as CSV to `/processed_data` folders**

Example transformation snippet:
```python
processed_patients_df = patients_df.dropDuplicates() \
    .na.drop() \
    .withColumn("loaded_date", current_date()) \
    .write.mode("overwrite").csv(f"{mount_point}/processed_data/patients_data_processed", header=True)
```

---

## 🖼️ Sample Visualization

*Load and analyze processed data:*

```python
# Load processed data for analysis
df = spark.read.csv(f"{mount_point}/processed_data/patients_data_processed", header=True, inferSchema=True)
display(df)
```

![Sample Data Preview](https://github.com/dibanga2800/nationalHospital/raw/main/assets/patient_data_preview.png)

---

## 🔒 Security

- **Secret management** for credentials via Databricks Secrets.
- **Unmounting** the storage after workflow for security and cost management.

---

## 📂 File Structure

```
nationalHospital/
│
├── NathospNotebook.ipynb    # Main Databricks ETL notebook
├── assets/                  # Images and diagrams for documentation
│   ├── etl_architecture.png
│   └── patient_data_preview.png
└── README.md                # This file
```

---

## 🤝 Contributing

PRs and suggestions are welcome!  
Please open issues for bug reports, enhancement proposals, or data questions.

---

## 📧 Contact

For questions or collaboration, reach out via [GitHub Issues](https://github.com/dibanga2800/nationalHospital/issues).

---

## 📜 License

This repo is licensed under the MIT License.

---

*Banner photo by [National Cancer Institute](https://unsplash.com/photos/7e5g6XcWz2s) on Unsplash.*
