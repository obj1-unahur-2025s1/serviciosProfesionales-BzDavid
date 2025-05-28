import clasesProfesionales.*

//Universidades
const universidadDeSanMartin = new Universidad(
  provincia = "Buenos Aires",
  honorarioRecomendado = 3500
)

const universidadDeRosario = new Universidad(
  provincia = "Santa Fe",
  honorarioRecomendado = 2800
)

const universidadDeCorrientes = new Universidad(
  provincia = "Corrientes",
  honorarioRecomendado = 4200
)

const universidadDeHurlingham = new Universidad(
  provincia = "Buenos Aires",
  honorarioRecomendado = 8800
)

//Profesionales
const juana = new ProfesionalVinculado(
  universidad = universidadDeRosario
)

const melina = new ProfesionalLitoral(
  universidad = universidadDeCorrientes
)

const rocio = new ProfesionalLibre(
  universidad = universidadDeHurlingham,
  honorarios = 5000,
  provincias = ["Santa Fe", "Cordoba", "Buenos Aires"]
)

const luciana = new ProfesionalLibre(
  universidad = universidadDeRosario,
  honorarios = 3200,
  provincias = ["Santa Fe", "Entre Rios"]
)

//Empresas
const empresa = new EmpresaDeServicios(
  honorarioDeReferencia = 3500
)

const laMejor = new EmpresaDeServicios(
  honorarioDeReferencia = 2800
)

//Instituciones
const asociadosPorLaPaz = new Institucion(
  universidadesReconocidas = [universidadDeSanMartin, universidadDeRosario]
)

const medicosAlrededorDelMundo = new Institucion(
  universidadesReconocidas = [universidadDeHurlingham, universidadDeCorrientes]
)

const diplomaticosMundiales = new Institucion(
  universidadesReconocidas = [universidadDeRosario, universidadDeHurlingham]
)

//Clubes
const clubRojo = new Club(
  provincias = ["Buenos Aires", "Santa Fe", "Cordoba", "Entre Rios"]
)

const clubBlanco = new Club(
  provincias = ["Buenos Aires", "Cordoba", "La Rioja"]
)

const clubAzulgrana = new Club(
  provincias = ["Cordoba", "La Rioja", "Corrientes"]
)

//Personas
const mirna = new PersonaSolicitante(
  provincia = "Santa Fe"
)

const ruben = new PersonaSolicitante(
  provincia = "Cordoba"
)

const lucas = new PersonaSolicitante(
  provincia = "Buenos Aires"
)