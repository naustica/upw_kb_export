import dask.dataframe as dd
import os
import uuid

df1 = dd.read_csv('kb_doi_list_w_header.csv')
df1 = df1.set_index('doi').persist()

filelist = [f for f in os.listdir('output') if f.endswith('.csv')]

for file in filelist:
    df2 = dd.read_csv('output/' + file)
    df = dd.merge(df1, df2, on='doi', left_index=True).compute()
    df.to_csv('output_kb/' + str(uuid.uuid4()) + '.csv', index=False)
