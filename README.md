# data-science-journey

Bridging clinical workflows and quantitative analytics. A public portfolio documenting my transition from Nursing to Health informatics / Data science through SQL, R, Python, statistics, and healthcare machine learning.

## Project structure

```text
.
├── data/
│   ├── raw/          # Original, immutable source data
│   ├── interim/      # Intermediate transformed data
│   ├── processed/    # Analysis-ready data
│   └── external/     # Data from external sources
├── notebooks/        # Exploratory notebooks
├── scripts/          # Reusable R scripts and functions
├── python/           # Reusable Python modules and scripts
├── sql/              # SQL queries and transformations
├── reports/          # Reports and rendered outputs
├── outputs/
│   ├── figures/      # Generated charts and visualizations
│   └── tables/       # Generated tables
└── tests/            # Tests for reusable code
```

## Working conventions

- Keep source data in `data/raw/` and avoid modifying it in place.
- Put exploratory work in `notebooks/`; move reusable code into `R/` or `python/`.
- Store SQL scripts in `sql/` and generated figures and tables in `outputs/`.
- Data files are ignored by Git. Do not commit sensitive or identifiable health information; document data sources and access requirements separately.

