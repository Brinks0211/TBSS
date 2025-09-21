#generate covariance matrix 0305
import pandas as pd
import numpy as np

ClusterPath = '/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/A1_SAND_HYDRAC_cluster.xlsx'
ClusterData = pd.read_excel(ClusterPath, sheet_name='Sheet1')
TotalData = pd.read_csv('./B1_SubTotalInfo.csv', encoding='GBK')
TotalData = pd.merge(ClusterData, TotalData, on="MRI_ID", how='inner')
TotalData.to_excel('./B1_SubTotalInfo_cluster.xlsx', sheet_name='Sheet1', index=True)
print(TotalData)

ConData = TotalData[TotalData['HYDRA_group']=='HC']
Cluster1Data = TotalData[TotalData['HYDRA_group']=='cluster1']
Cluster2Data = TotalData[TotalData['HYDRA_group']=='cluster2']

IndexList = ['MRI_ID', 'HYDRA_group', 'con', 'cluster1', 'cluster2', 'Gender_con', 'Gender_cluster1', 'Gender_cluster2', 
             'Age_con', 'Age_cluster1', 'Age_cluster2', 'Age2_con', 'Age2_cluster1', 'Age2_cluster2', 
             'AgeSex_con', 'AgeSex_cluster1', 'AgeSex_cluster2', 'Age2Sex_con', 'Age2Sex_cluster1', 'Age2Sex_cluster2', 
             'Gender_num', 'age', 'Age2', 'AgeSex', 'Age2Sex', 'Gender_num_demean', 
             'age_demean', 'Age2_demean','AgeSex_demean', 'Age2Sex_demean']

DesignMatrix = pd.DataFrame(columns=IndexList)

for Index in ['MRI_ID', 'HYDRA_group', 'Group', 'Gender_num', 'age']:
    DesignMatrix[Index] = round(TotalData[Index],4)

# generate Age2 gender_num age Age2 demean
DesignMatrix['Age2'] = DesignMatrix['age'] * DesignMatrix['age']
DesignMatrix['AgeSex'] = DesignMatrix['age'] * DesignMatrix['Gender_num']
DesignMatrix['Age2Sex'] = DesignMatrix['Age2'] * DesignMatrix['Gender_num']
DesignMatrix['Gender_num_demean'] = round(DesignMatrix['Gender_num'] - DesignMatrix['Gender_num'].mean(), 4)
DesignMatrix['age_demean'] = round(DesignMatrix['age'] - DesignMatrix['age'].mean(), 4)
DesignMatrix['Age2_demean'] = round(DesignMatrix['Age2'] - DesignMatrix['Age2'].mean(), 4)
DesignMatrix['AgeSex_demean'] = round(DesignMatrix['AgeSex'] - DesignMatrix['AgeSex'].mean(), 4)
DesignMatrix['Age2Sex_demean'] = round(DesignMatrix['Age2Sex'] - DesignMatrix['Age2Sex'].mean(), 4)

# generate matrix
DesignMatrix['con'] = TotalData['HYDRA_group'].apply(lambda x: 1 if x == 'HC' else 0)
DesignMatrix['cluster1'] = TotalData['HYDRA_group'].apply(lambda x: 1 if x == 'cluster1' else 0)
DesignMatrix['cluster2'] = TotalData['HYDRA_group'].apply(lambda x: 1 if x == 'cluster2' else 0)
DesignMatrix['Gender_con'] = DesignMatrix.apply(lambda data: data['Gender_num_demean'] if data['HYDRA_group']=='HC' else 0 , axis=1)
DesignMatrix['Gender_cluster1'] = DesignMatrix.apply(lambda data: data['Gender_num_demean'] if data['HYDRA_group']=='cluster1' else 0 , axis=1)
DesignMatrix['Gender_cluster2'] = DesignMatrix.apply(lambda data: data['Gender_num_demean'] if data['HYDRA_group']=='cluster2' else 0 , axis=1)
DesignMatrix['Age_con'] = DesignMatrix.apply(lambda data: data['age_demean'] if data['HYDRA_group']=='HC' else 0 , axis=1)
DesignMatrix['Age_cluster1'] = DesignMatrix.apply(lambda data: data['age_demean'] if data['HYDRA_group']=='cluster1' else 0 , axis=1)
DesignMatrix['Age_cluster2'] = DesignMatrix.apply(lambda data: data['age_demean'] if data['HYDRA_group']=='cluster2' else 0 , axis=1)
DesignMatrix['Age2_con'] = DesignMatrix.apply(lambda data: data['Age2_demean'] if data['HYDRA_group']=='HC' else 0 , axis=1)
DesignMatrix['Age2_cluster1'] = DesignMatrix.apply(lambda data: data['Age2_demean'] if data['HYDRA_group']=='cluster1' else 0 , axis=1)
DesignMatrix['Age2_cluster2'] = DesignMatrix.apply(lambda data: data['Age2_demean'] if data['HYDRA_group']=='cluster2' else 0 , axis=1)
DesignMatrix['AgeSex_con'] = DesignMatrix.apply(lambda data: data['AgeSex_demean'] if data['HYDRA_group']=='HC' else 0 , axis=1)
DesignMatrix['AgeSex_cluster1'] = DesignMatrix.apply(lambda data: data['AgeSex_demean'] if data['HYDRA_group']=='cluster1' else 0 , axis=1)
DesignMatrix['AgeSex_cluster2'] = DesignMatrix.apply(lambda data: data['AgeSex_demean'] if data['HYDRA_group']=='cluster2' else 0 , axis=1)
DesignMatrix['Age2Sex_con'] = DesignMatrix.apply(lambda data: data['Age2Sex_demean'] if data['HYDRA_group']=='HC' else 0 , axis=1)
DesignMatrix['Age2Sex_cluster1'] = DesignMatrix.apply(lambda data: data['Age2Sex_demean'] if data['HYDRA_group']=='cluster1' else 0 , axis=1)
DesignMatrix['Age2Sex_cluster2'] = DesignMatrix.apply(lambda data: data['Age2Sex_demean'] if data['HYDRA_group']=='cluster2' else 0 , axis=1)

DesignMatrix.to_csv('./B1_DesignMatrix_0311.csv', encoding='utf-8')
print(DesignMatrix)