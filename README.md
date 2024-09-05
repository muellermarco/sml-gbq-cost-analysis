# GBQ Costs Analysis

This project offers the possibility to create an AtScale model based on the GBQ job log information. It can be used to create these analyses based on AtScale users and their queries. There is a sample application for this in the PowerBI folder

### Settings

**Add atscale engine prooperties**
`query.includeComments.general.userId = True`
`query.includeComments.general.queryId = True`

**dataset settings**

- Adjust the dataset to the service accounts that is set for accessing AtScale to GBQ in the Warehouse connections
- Set the path to your region. ex. region-EU


datasets/query_log.yaml
```
  FROM
    'region-EU'.INFORMATION_SCHEMA.JOBS INF
  WHERE

  INF.user_email in('service_account1@myproject.iam.gserviceaccount.com','service_account2@myproject.iam.gserviceaccount.com')
  and INF.total_bytes_billed > 0

  ORDER BY creation_time  desc
```
