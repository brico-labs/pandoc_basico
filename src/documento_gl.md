---
title: Usando Pandoc
author:
- Sergio Alvariño <salvari@gmail.com>
tags: [Pandoc, Documentación, makefile, git]
date: abril-2016
lang: es-ES
abstract: |
  Unha chuleta para usar o Pandoc, copiada descaradamente de varios sitios de internet.
  
  Só para referencia rápida e persoal.
---

# ¿Cómo usar isto?

## Moi rápido

Clona o repo nun directorio :

    git clone https://bitbucket.org/salvari/pandoc_basico

Renomea o directorio:

    mv pandoc_basico miProyecto
    
Elimina a info de git

    rm -rf miProyecto/.git
    
Edita o ficheiro _meuProxecto/src/documento.md_ có teu editor de texto
favorito.

Executa:

make

  : Para xerar todos os ficheiros de saída y o ficheiro README.md
  (equivale a *make all*)
    
make clean

  : Para borrar todos os ficheiros de saída
  
make reset

  : Equivale a *make clean all*
    
## Mais detalles

O makefile está preparado para procesar **todos** os ficheiros con
extensión *.md* que haxa no directorio *src*. Isto permite escribir
documentos longos e dividilos en seccións, por exemplo poderíamos
ter os seguintes documentos no directorio *src*

    00_Comezo.md
    10_Capitulo_01.md
    20_Capitulo_02.md
    30_Conclusion.md
    40_apendices.md

Ao executar _make_ nos crearía **un só documento de saída**
concatenando todos os ficheiros. O orden en que os concatena é o mesmo 
orden  no que aparecen ao facer un *ls* por iso se nomean cunha
numeración ao principio que nos permita controlar a orden de procesado.

Se queres cambiar o nome do ficheiro de saída (*documento*)
terás que editar o makefile y cambiarlle a línea:

    target  := documento
    
Outras líneas que podes tocar no makefile son as que especifican
o idioma e os tipos de letra usados.

# ¿Qué é Pandoc?

Como nos din en <http://pandoc.org>, Pandoc é unha librería en Haskell
para facer a conversión de documentos dun formato markup a outro. E
tamén é unha ferramenta de línea de comandos que usa a librería.

O que nos permite Pandoc á hora de documentar un proxecto é
manter a documentación nun formato aberto y sinxelo (markdown)
e xerar saídas en distintos formatos (pdf, mediawiki, epub, html,
etc) cun simple comando.

# ¿Qué precisas ter instalado?

* Pandoc
* make
* git (no es imprescindible pero muy recomendable)
* As plantillas de Pandoc (ou *templates*)
* Un bó editor de texto

# Instalación



# Chuletario de Pandoc


## Backslash Escapes

Salvo que estemos dentro dun bloque de código ou de "código en
linea", **calquer carácter de puntuación o espacio** precedido de
contrabarra tratarase de forma literal, mesmo cando ese carácter
normalmente indique algún formato.

## Bloque de título

É unha forma rápida de indicar o título o autor ou autores e a
data. Ten que ir ao principio do documento:

    % título
    % autor(es) (separados por :)
    % data

Alternativamente pódese usar outro estilo para o bloque do título,
moito mais completo, en formato
[YAML](https://en.wikipedia.org/wiki/YAML), especificando
variables. Non pode usarse simultáneamente có anterior, hai que
escoller entre os dous estilos.

Pódense especificar todo tipo de variables
^[Ollo por que no makefile proposto especificase a linguaxe, así que a variable do bloque de título no vai ter efecto neste caso.].

    ---
    title: Título
    author:
    - Autor Uno <autor.uno@correo.com>
    - Outro autor <outroautor@correo.com>
    tags: [nothing, nothingness]
    date: xaneiro-2016
    lang: gl-ES
    abstract: |
      Este é o resumo.
    
      Con dous párrafos.
    ...
    ---

## Incrustar TeX e HTML

-   Os comandos TeX pásanse de xeito transparente ao Markdown, e
    afectan só a saída de LaTeX e ConTeXt; no resto dos casos bórranse
-   O código HTML pasará a saída sen cambios, pero o Markdown dentro
    dos bloques HTML procesase como Markdown

## Párrafos e retornos de línea

-   Un párrafo é unha ou mais líneas de texto separadas por unha linea en
    blanco do resto
-   Unha línea que remata con dous espacios, ou unha línea que remata
    cun fin de linea escapado (contrabarra seguida de retorno de
    linea) indica un cambio de linea manual

## Itálica, negrita, superescrito, subesctrito, tachado

    *Itálica* e **negrita** indícanse con asteriscos ou con guiós
     baixos.

    Para  ~~tachar~~ texto usa tildes dobles.

    Superscrito indicase así: 2^ndo^.

    Subescrito con tildes simples, así: H~2~O.

    Os espacios no superescrito e no subescrito teñen que ir
    escapados, p.ej., H~esto\ es \ un\ subescrito~.

## TeX matématico ou código incrustado en linea

    O TeX matemático vai entre signos $: $2 + 2$.

    O código en línea vai entre comillas invertidas: `echo 'hello'`

## Enlaces e imáxenes

    <http://example.com>
    <foo@bar.com>
    [inline link](http://example.com "Title")
    ![inline image](/path/to/image, "alt text")

    [reference link][id]
    [implicit reference link][]
    ![reference image][id2]

    [id]: http://example.com "Title"
    [implicit reference link]: http://example.com
    [id2]: /path/to/image "alt text"

## Notas ao pé da páxina

    As notas en linea son como
    esta: ^[Nótese que as notas en linea non poden ter mais dun párrafo.]
    As notas de referencia son como esta.[^id]

    [^id]:  As notas de referencia poden conter varios párrafos.

        Os párrrafos a continuación deben estar identados.

## Citas

    Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

    Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

    Blah blah [@smith04; @doe99].

    Smith says blah [-@smith04].

    @smith04 says blah.

    @smith04 [p. 33] says blah.

## Cabeceiras

    Cabeceira 1
    ========

    Cabeceira 2
    --------

    # Cabeceira 1 #

    ## Cabeceira 2 ##

As almohadillas de peche \# son opcionais. É necesario engadir unha línea en
blanco antes e despois de cada cabeceira.

## Listas

#### Listas Ordeadas

    1. example
    2. example
        1. sublista item 1
        2. sublista item 2

    A) example
    B) example

#### Listas desordeadas

Os items da lista deben ir marcados con '\*', '+', or '-'.

    +   example
    -   example
    *   example

As listas pódense anidar da forma usual:

    +   example
        +   example
    +   example

#### Listas de definición

    Term 1
    
    :   Definition 1
    
    Term 2
    
    :   Definition 2
        Second paragraph of definition 2.

## Blockquotes

    >   blockquote
    >>  nested blockquote

É preciso engadir lineas en blanco antes e despois dos bloques-cita.

## Tablas

      Right     Left     Center     Default
    -------     ------ ----------   -------
         12     12        12            12
        123     123       123          123
          1     1          1             1

    Table:  Demonstration of simple table syntax.

(Para tablas mais complexas consulta a [documentación de Pandoc](http://pandoc.org/README.html#tables).)

## Bloques de código

Os bloques de código empiezan con tres o más tildes; e rematan a lo menos co mesmo número de tildes:

    ~~~~~~~
    {code here}
    ~~~~~~~

Opcioalmente, pódese especificar a linguaxe que corresponde ao bloque de código:

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.haskell .numberLines}
    qsort []     = []
    qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
                   qsort (filter (>= x) xs)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Lineas horizontais

Tres ou mais guións ou asteriscos nunha linea (permitense espacios intercalados)

    ---
    * * *
    - - - -
    
## Bloques verbatim

Todo o texto identado cuatro espacios

    Exemplo: Isto é un bloque verbatim y por exemplo *isto* aparece
    tal cual e non en itálica.


# Bibliografía e referencias (ou material copiado si o prefires)

* Na [guía de usuario de Pandoc](http://pandoc.org/README.html)
  Importante leela para sacarlle todo o xugo a esta ferramenta
* Na
  [chuleta de Pandoc](https://github.com/dsanson/Pandoc.tmbundle/blob/master/Support/doc/cheatsheet.markdown)
  de [David Sanson](https://github.com/dsanson), perfecta para referencia rápida
* Para facer o makefile leín varios tutoriais e copiado
  descaradamente de varios sitios que esquecín apuntar (sintoo)
  
[`http://daringfireball.net/projects/markdown/syntax`{.url}]: http://daringfireball.net/projects/markdown/syntax
[`http://johnmacfarlane.net/pandoc/README.html`{.url}]: http://johnmacfarlane.net/pandoc/README.html
