import numpy as np


class voEjecucion:

    nbr_id_ejec = 0
    str_usuario_ejec = ''
    str_instancia_ejec = ''
    dttm_fecha_hora_ejec = ''
    str_bucket_s3 = ''
    str_tag_script = ''
    str_tipo_ejec = ''
    str_url_webscrapping = ''
    str_status_ejec = ''

    str_NombreDataFrame = ''

    def crearCSV(self):
        import pandas as pd

        dict_Ejecucion = {'id_ejec': [self.nbr_id_ejec],
                          'usuario_ejec': [self.str_usuario_ejec],
                          'instancia_ejec': [self.str_instancia_ejec],
                          'fecha_hora_ejec': [self.dttm_fecha_hora_ejec],
                          'bucket_s3': [self.str_bucket_s3],
                          'tag_script': [self.str_tag_script],
                          'tipo_ejec': [self.str_tipo_ejec],
                          'url_webscrapping': [self.str_url_webscrapping],
                          'status_ejec': [self.str_status_ejec]
                          }

        df = pd.DataFrame(dict_Ejecucion, columns=['id_ejec',
                                                   'usuario_ejec',
                                                   'instancia_ejec',
                                                   'fecha_hora_ejec',
                                                   'bucket_s3',
                                                   'tag_script',
                                                   'tipo_ejec',
                                                   'url_webscrapping',
                                                   'status_ejec',
                                                   ]
                          )

        df.to_csv(self.str_NombreDataFrame, index=False, header=False)

        return


class voArchivos:

    nbr_id_ejec = 0
    str_id_archivo = ''
    nbr_num_registros = 0
    nbr_num_columnas = 0
    nbr_tamanio_archivo = 0
    str_anio = ''
    str_mes = ''
    str_ruta_almac_s3 = ''

    str_NombreDataFrame = ''

    def crearCSV(self):
        import pandas as pd

        dict_Ejecucion = {'id_ejec': [self.nbr_id_ejec],
                          'id_archivo': [self.str_id_archivo],
                          'num_registros': [self.nbr_num_registros],
                          'num_columnas': [self.nbr_num_columnas],
                          'tamanio_archivo': [self.nbr_tamanio_archivo],
                          'anio': [self.str_anio],
                          'mes': [self.str_mes],
                          'ruta_almac_s3': [self.str_ruta_almac_s3]
                          }

        df = pd.DataFrame(dict_Ejecucion, columns=['id_ejec',
                                                   'id_archivo',
                                                   'num_registros',
                                                   'num_columnas',
                                                   'tamanio_archivo',
                                                   'anio',
                                                   'mes',
                                                   'ruta_almac_s3'
                                                   ]
                          )

        df.to_csv(self.str_NombreDataFrame, index=False, header=False)

        return


class voArchivos_Det:

    np_Campos = np.empty([0, 2])
    str_NombreDataFrame = ' '

    def crearCSV(self):
        import pandas as pd

        # Se construye el dataframe con base en el arreglo de campos
        columns = ['id_archivo', 'nombre_col']
        df = pd.DataFrame(data=self.np_Campos, columns=columns)

        # Se pasa a un csv
        df.to_csv(self.str_NombreDataFrame, index=False, header=False)

        return
