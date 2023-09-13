# list all global variables
globalVariables(unique(c(".",
                         # app_server: ‘data’
                         # client_by_dpt:
                         "region", "id_dpt", "n",
                         # mod_clients:
                         "priority", "entry_year", "n", "age_class",
                         # "fidelity_points",
                         # mod_clients: no visible binding for global variable ‘fra_sf’
                         # mod_clientsUI:
                         "priority", "age_class", "database", "fidelity_points",
                         "fra_sf", "pc"
)))
