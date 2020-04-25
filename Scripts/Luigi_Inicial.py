# Librerias de python
import luigi
import os

# Librerias de nosotros
import Luigi_Tasks as lt


class Task_05_CrearBD(luigi.Task):

    def run(self):
        # Si puede crear la base bien, generamos el archivo output
        if lt.CrearDB() == 0:
            os.system('echo OK > Task_05_CrearBD')

    def output(self):
        return luigi.LocalTarget('Task_05_CrearBD')


class Task_10_CrearDirectoriosEC2(luigi.Task):

    def requires(self):
        return Task_05_CrearBD()

    def run(self):
        # Si puede crear los directorios bien, generamos el archivo output
        if lt.CrearDirectoriosEC2() == 0:
            os.system('echo OK > Task_10_CrearDirectoriosEC2')

    def output(self):
        return luigi.LocalTarget('Task_10_CrearDirectoriosEC2')


class Task_20_CrearDirectoriosS3(luigi.Task):

    def requires(self):
        return Task_10_CrearDirectoriosEC2()

    def run(self):

        if lt.CrearDirectoriosS3() == 0:
            os.system('echo OK > Task_20_CrearDirectoriosS3')

    def output(self):
        return luigi.LocalTarget('Task_20_CrearDirectoriosS3')


class Task_30_CrearSchemasRDS(luigi.Task):

    def requires(self):
        return Task_20_CrearDirectoriosS3()

    def run(self):
        if lt.CrearSchemasRDS() == 0:
            os.system('echo OK > Task_30_CrearSchemasRDS')

    def output(self):
        return luigi.LocalTarget('Task_30_CrearSchemasRDS')


class Task_40_CrearTablasLinajeRDS(luigi.Task):

    def requires(self):
        return Task_30_CrearSchemasRDS()

    def run(self):
        if lt.CrearTablasLinajeRDS() == 0:
            os.system('echo OK > Task_40_CrearTablasLinajeRDS')

    def output(self):
        return luigi.LocalTarget('Task_40_CrearTablasLinajeRDS')


class Task_50_WebScrapingInicial(luigi.Task):

    def requires(self):
        return Task_40_CrearTablasLinajeRDS()

    def run(self):
        if lt.WebScrapingInicial() == 0:
            os.system('echo OK > Task_50_WebScrapingInicial')

    def output(self):
        return luigi.LocalTarget('Task_50_WebScrapingInicial')


class Task_60_EnviarMetadataLinajeRDS(luigi.Task):

    def requires(self):
        return Task_50_WebScrapingInicial()

    def run(self):
        if lt.EnviarMetadataLinajeRDS() == 0:
            os.system('echo OK > Task_60_EnviarMetadataLinajeRDS')

    def output(self):
        return luigi.LocalTarget('Task_60_EnviarMetadataLinajeRDS')

class Task_65_HacerFeatureEngineering(luigi.Task):

    def requires(self):
        return Task_60_EnviarMetadataLinajeRDS()

    def run(self):
        if lt.HacerFeatureEngineering() == 0:
            os.system('echo OK > Task_65_HacerFeatureEngineering')

    def output(self):
        return luigi.LocalTarget('Task_65_HacerFeatureEngineering')

class Tarea_70(luigi.Task):

    def requires(self):
        return Tarea_40()

    def run(self):
        if lt.WebScrapingRecurrente() == 0:
            os.system('echo OK > Tarea_70')

    def output(self):
        return luigi.LocalTarget('Tarea_70')


class Tarea_80(luigi.Task):

    def requires(self):
        return Tarea_70()

    def run(self):
        if lt.EnviarMetadataLinajeRDS() == 0:
            os.system('echo OK > Tarea_80')

    def output(self):
        return luigi.LocalTarget('Tarea_80')


if __name__ == '__main__':
    luigi.run()
