from matplotlib.backends.backend_agg import RendererAgg
import streamlit as st
import numpy as np
import pandas as pd
import xmltodict
from pandas import json_normalize
import urllib.request
import seaborn as sns
import matplotlib
from matplotlib.figure import Figure
from PIL import Image
from streamlit_lottie import st_lottie
import requests
import os
from matplotlib import pyplot as plt
import seaborn as sns
import pickle
from sklearn.pipeline import Pipeline
from sklearn.tree import DecisionTreeClassifier
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer
from sklearn.svm import SVC


matplotlib.use("agg")

_lock = RendererAgg.lock

plt.style.use('seaborn-whitegrid')
plt.rc('figure', autolayout=True)
plt.rc('axes', labelweight='bold', labelsize='large',
       titleweight='bold', titlesize=18, titlepad=10)

st.set_page_config(layout="wide")

def load_lottieurl(url: str):
    r = requests.get(url)
    if r.status_code != 200:
        return None
    return r.json()

lottie_book = load_lottieurl('https://assets4.lottiefiles.com/packages/lf20_7fx3rla1.json')
st_lottie(lottie_book, speed=1, height=200, key="initial")


row0_spacer1, row0_1, row0_spacer2, row0_2, row0_spacer3 = st.beta_columns(
    (.1, 2, .2, 1, .1))

row0_1.title('Predicting Loan Status')

with row0_2:
    st.write('')

row0_2.subheader(
    'A Web App by [Jesse Lu](https://github.com/JesseLuBass/lighthouse-data-notes)')

row1_spacer1, row1_1, row1_spacer2 = st.beta_columns((.1, 3.2, .1))

with row1_1:
    st.markdown("Hey there! Welcome to Jesse's Bank Data Analysis App. This app reads in a DataFrame of banking information and returns a predicition on the loan status for each observation. ")
    st.markdown(
        "**To begin, please select which subset of the banking information DataFrame you would like the model to predict on.** 👇")

row2_spacer1, row2_1, row2_spacer2 = st.beta_columns((.1, 3.2, .1))

df = pd.read_csv('data.csv').drop(['Loan_Status','Loan_ID'], axis=1)
first_20 = df.iloc[:20,:]
first_100 = df.iloc[:100,:]
entire_df = df.copy()

with row2_1:
    
    choose_df = [first_20,first_100,entire_df]
    default_df = st.selectbox('Select a subset of the dataframe', choose_df)
    st.markdown('**or**')
    st.markdown('You can make your own custom data from the selections below here')
    property_option = ['Urban', 'Semiurban','Rural']
    gender_option=['Male','Female']
    education_option = ['Graduate','Not Graduate']
    applicant_income_option =[1000,2000,3000,4000,5000,6000,10000,12000,14000]

    property = st.selectbox('Option for Property Area', property_option)
    gender = st.selectbox('Option for Gender', gender_option)
    applicant = st.selectbox('Option for Income', applicant_income_option)
    education = st.selectbox('Option for Education Level', education_option)

    if st.button('Make my own custom data'):
        data = {
        'Gender': gender,
        'Married': 'Yes',
        'Dependents': '0',
        'Education': education,
        'Self_Employed': 'No',
        'ApplicantIncome': applicant,
        'CoapplicantIncome': 1622,
        'LoanAmount': 150,
        'Loan_Amount_Term': 342.0,
        'Credit_History': 1,
        'Property_Area': property 
        }
        df =pd.DataFrame(data, index=[0])
        chosen_df=(df)
    else: 
        chosen_df = default_df


row3_space1, row3_1, row3_space2, row3_2, row3_space3 = st.beta_columns(
    (.1, 1, .1, 1, .1))

with row3_1, _lock:
    st.subheader('Applicant Income Bargraph')
    plot_df = chosen_df['ApplicantIncome'].dropna()
    fig, ax = plt.subplots()
    ax.hist(plot_df)
    st.pyplot(fig)
with row3_2:
    st.subheader('Here is a view of the dataframe.')
    st.dataframe(chosen_df)

st.write('')
row4_space1, row4_1, row4_space2, row4_2, row4_space3 = st.beta_columns(
    (.1, 1, .1, 1, .1))

with row4_1:
    st.subheader('Applicant Income Boxplot')
    plot_df = chosen_df['ApplicantIncome'].dropna()
    fig, ax = plt.subplots()
    ax.boxplot(plot_df)
    st.pyplot(fig)

with row4_2:
    st.subheader('Loan Amount Bargraph')
    plot_df = chosen_df['LoanAmount'].dropna()
    fig,ax = plt.subplots()
    ax.hist(plot_df)
    st.pyplot(fig)

model = pickle.load( open( "model_p", "rb" ) )

res = model.predict(chosen_df)
st.markdown(" Here is the prediction from the dataset you've selected, with a SVC model ")
st.write(res)