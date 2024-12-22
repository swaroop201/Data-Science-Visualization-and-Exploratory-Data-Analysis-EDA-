# Data Science Visualization & Exploratory Data Analysis (EDA)

## 📊 Project Overview

This project conducts a comprehensive Exploratory Data Analysis (EDA) on terrorist attack incidents, examining patterns, correlations, and key statistics using multiple analytical tools. The analysis compares the effectiveness of different data science tools (Python and R) for both analysis and visualization purposes.

### 🎯 Objectives
- Perform thorough exploratory data analysis using multiple tools
- Compare and contrast visualization capabilities across different platforms
- Extract meaningful insights from complex security incident data
- Evaluate tool effectiveness for different analytical tasks

## 🔍 Data Analysis

### Dataset Features
- Attack types and methods
- Geographical distribution
- Casualty statistics (killed and wounded)
- Weapon types and success rates
- Temporal patterns

### Analysis Techniques
- Statistical analysis (ANOVA, correlation studies)
- Geospatial analysis
- Distribution analysis
- Success rate evaluation
- Casualty pattern analysis

## 📈 Key Visualizations

1. **Attack Distribution**
   - Geographic heatmaps of incident locations
   - Attack type distribution plots
   - Weapon type frequency analysis

2. **Casualty Analysis**
   - Correlation between kills and wounded
   - Country-wise casualty distributions
   - Attack success rate visualizations

3. **Geographic Insights**
   - Country-specific incident counts
   - Regional pattern analysis
   - Hot-spot identification

## 🛠️ Tools Comparison

### Python
**Strengths:**
- Superior visualization quality
- Extensive customization options
- Excellent for complex plots
- Strong community support

**Use Cases:**
- Heatmaps
- Geographic visualizations
- Distribution plots
- Correlation matrices

### R
**Strengths:**
- Efficient statistical analysis
- Streamlined data processing
- Built-in statistical functions
- Excellent for quick analysis

**Use Cases:**
- Statistical computations
- Basic plotting
- Data preprocessing
- Quick exploratory analysis

## 📝 Key Findings

1. **Attack Patterns**
   - Facility/Infrastructure and bombing attacks are most common
   - Hostage-taking and hijacking show highest success rates
   - Incendiary weapons are frequently used

2. **Geographical Insights**
   - Australia and Papua New Guinea show highest incident counts
   - Attack patterns vary significantly by region
   - Scattered distribution in high-risk areas

3. **Casualty Analysis**
   - Moderate positive correlation between kills and wounded (0.54)
   - Most incidents involve relatively low casualties
   - Medical response capabilities affect survival rates

## 🚀 Getting Started

### Prerequisites
```bash
# Python dependencies
pip install pandas numpy seaborn matplotlib plotly

# R packages
install.packages(c("ggplot2", "dplyr", "tidyr", "corrplot"))
```

### Repository Structure
```
├── data/
│   └── terrorist_attacks.csv
├── notebooks/
│   ├── python_analysis.ipynb
│   └── r_analysis.R
├── visualizations/
│   ├── python_plots/
│   └── r_plots/
└── README.md
```

## 📊 Usage

1. Clone the repository:
```bash
git clone https://github.com/swaroop201/data-science-visualization-eda.git
```

2. Navigate to the project directory:
```bash
cd data-science-visualization-eda
```

3. Open the Jupyter notebook or R script to view the analysis:
```bash
jupyter notebook notebooks/python_analysis.ipynb
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Data source: [Dataset Name/Source]
- Inspiration: Security analysis and visualization techniques
- Tool documentation and communities
