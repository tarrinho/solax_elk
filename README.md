# solax_elk
Solax Inverter json to ELK Stack (ElasticSearch + Logshtash + Kibana)


*Goal:
Retrieve data from my Solax Inverter and inject into my ELK Stack


*Step 1:
Can I get the data from Solax?
    Where can I get it from?
     http://<solaxIP>/api/realTimeData.htm
    
   Can I add a timestamp to the event?
    Yes -> here https://github.com/tarrinho/solax_elk/blob/master/get_data_solax.sh
     
   Example of the output
     
     {"method":"uploadsn","version":"Solax_SI_CH_2nd_20180709_DE01","type":"AL_SE","SN":"A8215E8D","Data":[4.1,0.0,348.3,0.0,3.4,233.2,752,41,4.8,4806.1,2,1428,0,54.10,10.47,567,27,72,0.0,2258.4,,,,,,,,,,,,,,,,,,,,,,0.00,0.00,,,,,,,,49.98,,,0.0,0.0,0,0.00,0,0,0,0.00,0,9,0,0,0.00,0,9],"Status":"2","Date":"2020-06-27T15:55:11+01:00"}


*Step 2: 
Can I parse that data?
  
   What does it mean?
       Thanks Hobi I was able to parse it -> https://github.com/GitHobi/solax/wiki/direct-data-retrieval
       Internal file for backup -> here https://github.com/tarrinho/solax_elk/blob/master/backup_from_GitHobi_solax
       
       
   Now that I have that log file how can I parse it?
       Grok pattern
     
     \A\{\"method\":\"%{CISCO_REASON:solax_action}\",\"version\":\"%{CISCO_REASON:solax_version}\",\"type\":\"%{CISCO_REASON:solax_type}\",\"SN\":\"%{CISCO_REASON:solax_version}\",\"Data\":\[%{NUMBER:solax_pv1_current:float},%{NUMBER:solax_pv2_current:float},%{NUMBER:solax_pv1_voltage:float},%{NUMBER:solax_pv2_voltage:float},%{NUMBER:solax_grip_output_current:float},%{NUMBER:solax_grid_network_voltage:float},%{NUMBER:solax_grid_power:float},%{NUMBER:field7:float},%{NUMBER:solax_inverter_yield_today:float},%{NUMBER:solax_inverter_total_yield:float},%{NUMBER:solax_grid_feed_in_power:float},%{NUMBER:solax_pv1_input_power:float},%{NUMBER:solax_pv2_input_power:float},%{NUMBER:solax_battery_voltage:float},%{NUMBER:solax_dis_charge_current:float},%{NUMBER:solax_battery_power:float},%{NUMBER:solax_battery_temperature:float},%{NUMBER:solax_battery_remaining:float},%{NUMBER:field18:float},%{NUMBER:solax_battery_yield_total:float},,,,,,,,,,,,,,,,,,,,,,%{NUMBER:solax_grid_exported:float},%{NUMBER:solax_grid_imported:float},,,,,,,,%{NUMBER:solax_grid_frequency:float},,,%{NUMBER:field51},%{NUMBER:field52},%{NUMBER:field53},%{NUMBER:field54},%{NUMBER:field55},%{NUMBER:field56},%{NUMBER:field57},%{NUMBER:field58},%{NUMBER:field59},%{NUMBER:field60},%{NUMBER:field61},%{NUMBER:field62},%{NUMBER:field63},%{NUMBER:field64},%{NUMBER:field65}],\"Status\":\"%{NUMBER:solax_status_number:float}\",\"Date\":\"%{TIMESTAMP_ISO8601:solax_event_date}\"\}
       
       
  Try it here: https://grokdebug.herokuapp.com/


*Step 3:

Injecting file log into elasticsearch via logstash
https://github.com/tarrinho/solax_elk/blob/master/logstash_solax.conf

*Step 4:

Adding the Index Pattern to Kibana and starting the visualization :D 
    
   ![Kibana Dashboard with Solax data](https://github.com/tarrinho/solax_elk/blob/master/Kibana.Dashboard-Solax-data.png) 
       
