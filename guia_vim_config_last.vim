" Configuración VIM
" 2018 Demian Molinari - demianmolinari@yahoo.com

" INDICE
" ======
"
" (utilice el número seguido de G, gg o bien haga :<numero>)
"
" 0. NOTA.....................................17
" 1. SENTIDO COMÚN............................40
" 2. RELACIONADO CON LA BÚSQUEDA..............98
" 3. PARA MAYOR COMODIDAD.....................117
" 4. RELACIONADOS CON LA PROGRAMACIÓN.........316
" 5. VIM ES UN MUNDO!.........................507
" 6. BUSCANDO ARCHIVOS, LINEAS, PALABRAS......903
" 7. BUSCAR, SUBSTITUIR.......................1204
" 8. PLUGINS MÍNIMOS..........................1371
" 9. EXTRA PLUGINS............................1596
" 10 DICCIONARIOS DE SINTAXIS.................1680

" 0 - NOTA -{{{
"
" Este fichero puede parecer un archivo de configuración, mas no lo es, al
" menos, no uno al uso.
"
" Sin embargo, puede usarse como tal, puesto que, si bien es muchísimo más
" largo que un archivo vimrc tradicional, es básicamente por estar lleno de
" comentarios. Es un archivo que intenta valer para todo sistema operativo
" (TODO: testearlo en más) y asegurar máxima compatibilidad en la medida de lo
" posible.
"
" No estaría de más, sin embargo, que si alguien quiere usar esta configuración
" como guía, lo haga pensando que quizá sea mejor leer el archivo, copiar las
" configuraciones que parezcan interesantes y evitarse tener líneas y líneas
" explicación redundate y que no pinta nada en un vimscript como este
"
" El objetivo de este archivo es que sirva más como una guía que como un
" verdadero archivo de configuración... Sin embargo también es, de momento, mi
" configuración más actualizada. No soy un genio de Vim, de hecho llevo poco
" más de un año con él y si bien me muevo con bastante soltura, no hace
" demasiado que realmente me propuse conocer a fondo sus posibilidades e
" intentar adentrarme más en la configuración. Lo que he aprendido me ha
" sorprendido más a mí mismo que a nadie, pues básicamente viene a decir que un
" programa con casi 30 años encima ha ido evolucionando hasta incluir la
" mayoría de funcionalidades que encontramos en IDEs modernos y por las que o
" bien se nos cobra o se nos roba la mitad de los recursos del sistema.
"
"}}}

" {{{ 1. SENTIDO COMÚN
"""""""""""""""""""""
" Configuraciones básicas de Vim en las que las mayoría de usuarios están de
" acuerdo o bien tienen leves discrepancias.

" IGNORAR LOS ERRORS CUANDO SE CAMBIA DE BUFFER SIN GUARDAR
set hidden

" PERMITE USAR EL RATÓN EN LA CONSOLA
set mouse=a

" DEJA DE PITAR!!!!
set noerrorbells visualbell t_vb=

" AMPLIA EL HISTORIAL DE COMANDOS A 500
if &history < 500
  set history=500
endif

" ENCODING
set encoding=utf-8

" COMBINA NÚMERO DE LÍNEA Y NÚMEROS RELATIVOS
set number relativenumber
" con esta combinación ya no tenemos necesidad de contar si queremos avanzar o
" retroceder líneas concretas, si bien esta no es la mejor praxis del mundo
" para moverse por el documento, es útil cuando sí es necesaria.
" Recomiendo sin embargo utilizar otros movimientos más significativos (con
" saltos, con objetos textuales)
" puede parecernos peor en el momento de insertar rangos en un comando, sin
" embargo pueden utilizarse los números relativos como rango también si los
" precedemos de un signo '-' o '+':
"   -3,.s/foo/bar >> sustituye foo por bar en desde 3 líneas atrás hasta la
"                    actual.
"   -17,309t+12   >> copia desde 17 líneas antes hasta la 309 a una posición
"                    12 líneas adelante de la actual.

" permite a la tecla backspace retroceder línea
set backspace=eol,start,indent

" también las flechas (o no?)
set whichwrap+=<,>,[,] " ver :h whichwrap para más opciones
" pero no a la h y la l
set whichwrap-=h,l

" mostrar siempre statusline (con ruler)
set ruler
set laststatus=2

" evitar cosas raras que pasan con el programa:
"
" a veces O tarda demasiado en abrir una línea
:set timeout timeoutlen=1000 ttimeoutlen=100
" literally: Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1

" Van a haber muchas configuraciones, así que es mejor tener a mano la carpeta donde estas se guardan:
if has('win32') " la carpeta se llama distinto en Windows
  let g:vim_at_user_home = $USERPROFILE."/vimfiles"
else
  let g:vim_at_user_home = $HOME."/.vim"
endif

" FOLLOW THE LEADER
" Vim ofrece una tecla a la que llama leader, que sirve básicamente para crear
" atajos de teclado. La tecla <leader> precede a la mayoría de atajos de
" teclado configurados por el usuario. Vim recomienda trabajar de esta manera y
" no encuentro realmente motivos para discrepar. Lo único que hace falta es
" situarla en una posición accesible. Para mí, esta posición es el espacio.
" Espacio, en modo normal, hace lo mismo que la l o la flecha a la derecha.
" Completamente reemplazable. Además, la tecla por defecto para el <leader> en
" Vim es \ ... prácticamente imposible de alcanzar.

nnoremap <space> <Nop>
let mapleader = " "
let g:mapleader = "\<Space>"
"}}}

" {{{ 2. RELACIONADO CON LA BÚSQUEDA
"""""""""""""""""""""""""""""""""""

" INCREMENTAL para que nos desplace a medida que buscamos
set incsearch

" SMARTCASE para que casen minúsculas con todo y mayúsculas con mayúsculas
set ignorecase
set smartcase

" HIGHLGHT --> para resaltar mejor la palabra: márcala - incluso así hay veces
" que no es suficiente
set hlsearch

" un atajo de teclado para desmarcarla, más usado de lo que uno se piensa:
" (Antes usaba <ESC> pero por lo visto no es recomendable mappear NADA a Esc)
nnoremap <leader><leader><leader> :noh<CR>
"}}}

" {{{ 3. PARA MAYOR COMODIDAD
""""""""""""""""""""""""""""

" Una herramienta típica para organizar contenidos es el pliegue de texto.
" Poder plegar fragmentos del texto y comprimirlos a una línea permite la
" navegación más rápida por un documento. Además, nos aportará ciertas
" ventajas en cuanto a movimiento.
"
" PLIEGUES DE TEXTO
" Vim puede plegar texto según distintos factores. Los más sencillos es a
" través de la indentación o bien a través de un marcador. Existen fórmulas
" más complejas, similares a las de IDEs más potentes, que permiten crear un
" patrón textual y plegar todo lo que esté dentro del mismo. Sin embargo lo
" considero innecesario, ya que acabo haciendo los folds manualmente la
" mayoría de veces y así aprovecho para comentar las funciones. Hay más
" información sobre métodos avanzados de pliegue en el siguiente video:
"
"   http://vimcasts.org/episodes/writing-a-custom-fold-expression/
"
" Sin embargo, yo me decanto por el uso de los marcadores:
set foldmethod=marker

" con esto activo, podemos seleccionar cualquier fragmento de texto y con
" la combinación 'zf' haremos un pliegue de ese fragmento.
" Vim automáticamente insertará los marcadores al principio y al final.
" Requiere cierta costumbre situarse en el lugar correcto.
" También es importante saber cómo interactuar con los pliegues una vez hecho,
" de lo contrario el texto permanecerá siempre oculto...
"
"   za  abre/cierra pliegues
"   zc  cierra un pliegue
"   zM  cierra un pliegue y todos los que estén en el mismo anidado
"   zd  borra el pliegue
"   zD  borra el pliegue y todos los que estén en el mismo anidado
"   zj  salta hasta el siguiente pliegue
"   zk  vuelve atrás hasta la última línea del pliegue anterior
"   zv  revela el cursor si un pliegue ha sido cerrado
"
" Especialmente útil es la capacidad de movernos con zj y zk pues son dos
" movimientos más que podemos utilizar para aplicar funciones, como comentar
" rápidamente todo lo que haya en un pliegue, etc.

" Los marcadores son quizá un tanto limitados para algunos casos, sobre todo en
" html y derivados con exceso de marcaje.
" Nos puede pasar que tengamos que comentar las líneas donde Vim haya puesto
" los marcadores o que no ponga los marcadores en el sitio correcto, sino en la
" última línea de la selección. Para estos casos, recomiendo utilizar el modo
" Línea Visual 'V' para seleccionar el texto de manera adecuada y dejar una
" línea en blanco de separador tanto arriba como abajo.

" como editar el archivo de configuración es típico... le he creado un comando
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>
" mucha gente hace que al guardar el archivo se vuelva a cargar la config,
" no me gusta mucho esa práctica, pero aprovecho para recordar que eso mismo
" se puede conseguir haciendo
"   :so %

" UTILIZAR EL PORTAPAPELES POR DEFECTO DEL SISTEMA OPERATIVO (REGISTRO POR
" DEFECTO * MENOS EN TERMINALES, QUE ES +)
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'
" en cualquier caso, al tener el portapapeles 'plus' vim sigue guardando la
" copia en ambos registros: si algo está en * también está en +, sin embargo,
" esto no funciona a la inversa.

" DEJA 3 LÍNEAS DE MARGEN AL HACER AVANZAR LA PANTALLA
if !&scrolloff
  set scrolloff=3
endif
" Y 3 COLUMNAS AL AVANZAR EN HORIZONTAL
if !&sidescrolloff
  set sidescrolloff=3
endif

" AMPLIA EL ÁREA DE COMANDOS
" básicamente para poder leer enteros posibles errores cuando se entra a vim
" evitando de esta manera que salga el mensaje 'Press ENTER to continue' que
" es muy molesto.
set cmdheight=2

" INDICA LA LÍNEA DEL CURSOR
set cursorline

" en el caso de operar con recursos muy limitados, con este comando podemos
" copiar y pegar texto incluso sin tener vim compilado con clipboard
" mantener activo el menor tiempo posible, que se carga los mappings en insert
set pastetoggle=<F2>

" VENTANAS PARTIDAS A LA DERECHA Y ABAJO (POR COSTUMBRE)
set splitbelow
set splitright

" IDIOMA E IDIOMA DE LOS MENÚS
let $LANG='es'
set langmenu=es

" ARCHIVOS TEMPORALES
" Utilizo estos directorios dentro de vim para mantener archivos temporales que
" permiten recuperación de ficheros si algo va mal (si bien casi nunca pasa)
" Si no existen los directorios, los crea, y luego los utiliza para almacenar
" estos archivos. Vim por defecto tiende a guardarlos en el mismo lugar donde
" esté el archivo que estamos editando, lo que acaba ocasionando que la carpeta
" se llene de basura

" if has('persistent_undo')
"   if !isdirectory(g:vim_at_user_home.'/undo')
"     call mkdir(g:vim_at_user_home . '/undo', 'p', 0700)
"   endif
"   set undodir=g:vim_at_user_home/undo
"   set undofile
" endif
" if !isdirectory(g:vim_at_user_home.'/bks')
"   call mkdir(g:vim_at_user_home . '/bks', 'p', 0700)
" endif
" set backupdir=g:vim_at_user_home/bks

" if !isdirectory(g:vim_at_user_home.'/swap')
"   call mkdir(g:vim_at_user_home . '/swap', 'p', 0700)
" endif
" set directory=g:vim_at_user_home/swap

" " Uno más para hacer de los pliegues de nuestros archivos algo persistente
" if has('mksession')
"   if !isdirectory(g:vim_at_user_home.'/views')
"     call mkdir(g:vim_at_user_home . '/views', 'p', 0700)
"   endif
"   set viewdir=g:vim_at_user_home/views
"   " para guardar la configuración de pliegues, teclear :mkview
" endif

" Realmente estos archivos me molestaban y terminé por desactivarlos: total la
" mayoría de cosas están en un control de versiones o bien son archivos de
" rápida edición. Pero quizá con un poco de paranoia en el caso de que algo
" vaya mal, he decidido empezar a usarlos. También es recomendable borrarlos
" cada algún tiempo, para no ocupar espacio en exceso.
" En el caso de que se quieran desactivar, substituir las líneas anteriores por estas:
set nowritebackup
set nobackup
set noswapfile

" AL UNIR LÍNEAS, RESPETAR LA PUNTUACIÓN Y LOS ESPACIOS.
set nojoinspaces
" Y ELIMINAR LAS MARCAS DE COMENTARIO AL HACERLO:
set formatoptions+=j

" Y DE PASO, NO NOS MOVAMOS DE SITIO.
nnoremap J mzJ`z

" -- MODO GUI
"  alguna config específica del modo gui para hacerlo más bonito
if has("gui_running")
  " eliminar menú
  set guioptions=gt
  " habilita todo el espectro cromático disponible (jeje)
  set t_Co=256
  " manera en que se pintan las tabs
  set guitablabel=%M\ %t
  " colores
  colorscheme desert " creo que es la más potable de serie -
  " alternativas son:
  " 'darkblue' y 'koehler'  ...quizá 'peachpuff' en colores claros
  " tamaño de ventana
  set columns=200
  set lines=60
  " arreglaremos la fuente según sistema operativo
  if has('win32')
    " en windows es especialmente horrible FixedSys, así que pongo una segunda
    " fuente por si acaso no tengo instalada la mía:
    set guifont=Courier\ Prime\ Code:h14,Lucida\ Console:h11
  elseif has('mac')
    set guifont=Hermit:h16,Courier\ Prime\ Code:h16 
    " la de sistema es una buena alternativa
  else
    set guifont=Ubuntu\ Mono 
    " la de sistema es suficiente sino
  endif
endif

" VICIOS VENIDOS DE OTROS EDITORES
" <C-X> y <C-C> que se comporten como en windows
" solo en visual mode
vnoremap <c-x> "+d
vnoremap <c-c> "+y
" en modo insertar, los registros de portapapeles se pueden acceder con <C-R>
" y el identificador (por defecto + o *)
" y <C-V> permite insertar caracteres unicode (<C-V>u seguido del código...)

" también me gusta Ctrl+Backspace and Ctrl+Del para borrar palabras enteras
" Ctrl+Backspace equivale a <C-W> de serie... pero no he encontrado nada para
" <C-DEL>
inoremap <C-BS> <C-W>
inoremap <C-Del> <C-O>dw
" Ctrl+u borra la línea entera en modo insertar... debería borrar solo lo nuevo
" que se haya escrito:
" Con esta pequeña configuración C-U funciona igual que siempre, pero podemos
" recuperar el texto perdido
inoremap <C-U> <C-G>u<C-U>
" para rehacer hay que salir a modo normal y apretar la u
" <C-G>u básicamente genera un nuevo registro de cambio, de manera que si

" MAPPINGS ADICIONALES ÚTILES:
"
" SELECCIONAR TODAS LAS LINEAS
nnoremap <leader>a ggVG
" EN MODO VISUAL, CON TABULADOR PODER AUMENTAR O BAJAR LA INDENTACIÓN:
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
"}}}

" {{{ 4. RELACIONADOS CON LA PROGRAMACIÓN
""""""""""""""""""""""""""""""""""""""""""

" DEFINE LAS TABULACIONES MÁS À LA MOD
set shiftwidth=2 softtabstop=2
set tabstop=2 " algunos programadores no recomiendan cambiarlo,
" sin embargo tengo mis motivos como veremos
set smarttab " para aumentarle el IQ
set autoindent " auto indentación
" Mucha gente substituye tabulaciones por espacios para evitar problemas en el
" trabajo en equipo o en distintos entornos (cuánto mide una tabulación?)
" Sin embargo yo encuentro que es mejor hacer esto al guardar, ya que las
" tabulaciones sí las podemos controlar dentro de Vim y ponerlas a nuestro
" gusto, lo que nos permite orientar el espacio mucho mejor:
" En definitiva: unas funciones que activen/desactiven el uso de espacios (y
" actualiza el documento entero)

" PRIMERO, ASEGURARSE DE QUE EL MODO POR DEFECTO ES NOEXPANDTAB
set noexpandtab

function! Set_Tabs() abort
  if(&l:expandtab) " si se están usando tabulaciones
    set noexpandtab " desactivarlas
    exec 'keepjumps %retab!'
    "y convertir el texto a tabulaciones
  endif
endfunction

function! Set_Spaces() abort
  if (!&l:expandtab) " si no se están usando espacios
    set expandtab " activar el uso de espacios
    " y convertir el texto a espacios
    exec 'keepjumps %retab'
  endif
endfunction

" y una serie de autocomandos que se encargan de guardar siempre como espacios
augroup saving_text
  autocmd!
  autocmd BufWritePre * call Set_Spaces()
  autocmd BufWritePost * call Set_Tabs()
augroup end

" Utilizo dos funciones en vez de una para asegurarme que, si por algún motivo
" he cambiado la configuración y estoy utilizando espacios, que el programa
" guarde como espacios, pues NO SE DEBERÍA USAR TABULACIONES.
" hay que tener en cuenta que para que esto funcione, la configuración usada
" tiene que ser la misma que la mía: utilizar siempre tabs y que la medida
" siempre sea la misma en tabstop, softtabstop y shiftwidth (en mi caso, 2)
" el comando keepjumps sirve para que la orden ejecutada a continuación ignore
" los saltos de línea, de esta manera cuando hacemos 'undo' después de guardar,
" no nos lleva a la primera línea del text (efecto del %retab)

" El motivo por el cual me gusta usar los tabuladores es porque Vim puede
" mostrarlos y así servirnos de guía visual para la indentación correcta

" un atajo para mostrar/ocultar los caracteres invisibles:
nnoremap çli :set list! list?<CR>
" y de paso, los maquetamos el caracter '…' requiere utf-8, así que puede ser
" que no se muestre correctamente en algunos entornos (substituir por '>')

set listchars=tab:\|\ ,eol:¬,extends:…,precedes:…,trail:.,nbsp:·
" ^        ^     ^         ^          ^       ^
" |        |     |         |          |     espacio que no admite
" |        |     |         |          |       quiebro de línea.
" |        |     |_________|  espacio en blanco
" |        |          |
" |        |        marca que una línea sigue fuera de la pantalla
" |        |
" |      final de línea
" tabulaciones

" habilitar syntaxis
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" habilitar identación y plugins
if has('autocmd')
  filetype plugin on
  filetype indent on
endif

" alerta en la columna 80
set colorcolumn=80

" máximo ancho de texto ??
set textwidth=0 " tener un texto que se corta solo y se reformatea a 80
" caracteres puede parecer una buena idea, pero molesta la mayor
" parte del tiempo cuando uno hace php o html...
" con la columna de color es más que suficiente

set linebreak " y de paso que si hay que romper el texto, que sea por palabras

" activar-desactivar 'wrap' para el texto
" empieza desactivado
set nowrap
" los caracteres invisibles tienen que estar desactivados para que wrap
" funcione, pero por defecto los dejaremos activados.
set list

" de normal no utilizaremos wrap, pero para archivos de texto, es mejor
" tenerlo activo.
autocmd! BufNewFile,BufRead *.txt,*.mkd,*.md,*.tex set wrap nolist
autocmd! BufNewFile,BufRead *.txt,*.mkd,*.md,*.tex set tw=0

" en cualquier caso, este comando activa y desactiva {wr}ap y list, ya que wrap
" y list no funcionan juntos
nnoremap <Leader>wr :set wrap!<CR>:set list! wrap?<CR>

" también modifico los mapeos básicos de movimiento de arriba-abajo e
" inicio-fin pues con el wrap puesto los comandos de serie me confunden mucho
nnoremap <expr>j expand(&l:wrap) == 1 ? "gj" : "j"
nnoremap <expr>k expand(&l:wrap) == 1 ? "gk" : "k"
nnoremap <expr>^ expand(&l:wrap) == 1 ? "g0" : "^"
nnoremap <expr>$ expand(&l:wrap) == 1 ? "g$" : "$"

" NOTA:
" existe también el llamado hardwrap, que básicamente es pedirle a vim que
" reformatee según unos parámetros de ancho de texto, 'padding' y similar...
" puede ser útil en algún caso, pero en general lo deshecho y no lo utilizo.
" El mappeo por defecto hace que intente formatear a 80 caracteres
" la combinación de teclas es
"
"   gw{movimiento}  formatea lo que se le pase como movimiento/objeto
"   gq{movimiento}  lo mismo, pero se queda en el final del movimiento

" MATCHIT PLUGIN
packadd! matchit " este plugin viene de serie con vim, pero desactivado y
" le permite moverse con '%' no sólo entre paréntesis y
" similares sino también entre tags de html/xml

" formato de archivo unix por defecto y preferencias para segundas opciones
set fileformat=unix
set ffs=unix,dos,mac

" si alguna vez abrimos un archivo cuyas líneas acaban todas en ^M, habrá que
" substituirlas todas... esto es especialmente problemático si nos pasa en el
" propio vimscript.
"   %s/^.*<C-K><C-M>$//g ejecutar este comando lo arreglará like nobody's
"                        business

" HABILITAR AUTOCOMPLETADO INTELIGENTE 'omnifunction'
set omnifunc=syntaxcomplete#Complete

" Vim tiene dos funciones para autocompletar por defecto: la omni y la de
" archivo, la de archivo se llama con <C-P> o <C-N> y utiliza todas las
" palabras que estén en el documento actual y la función de autocompletado
" 'omni' se llama con <C-X><C-O>
" <C-X><C-O> es harto complicado para una función que deberíamos usar bastante:
" F2 es autocompletar o bien <C-L>
inoremap <F2> <C-X><C-O>
inoremap <C-L> <C-X><C-O>

" con estos remappings podremos usar las flechas, enter y escape para
" seleccionar la compleción que más nos interese, muy similar a cualquier otro
" IDE, muy útil
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" La Omnicompletion es muy útil... puede autocompletar no sólo leyendo ciertos
" diccionarios internos de vim, sino también con el archivo de tags y los
" nombres de archivos que hayan en el PWD
"
"   <C-X><C-O>    Tags, Funciones conocidas y palabras recientes
"   <C-X><C-F>    Archivos

inoremap <C-F> <C-X><C-F>

" también me es muy útil poder usar <C-Enter> y <SHIFT-ENTER> para hacer
" saltos de línea sin tener que estar necesariamente al final o bien para
" saltar hasta el final (para añadir, por ejemplo, un ; al final de línea)
inoremap <C-CR> <Esc>mmo
inoremap <S-CR> <Esc>mmA

" con el comando establezco una marca en la posición en la que estaba antes de
" saltar, así puedo volver atrás si quisiera, algo que también mappearé en
" <C-B>

inoremap <C-B> <Esc>'mi

"por defecto <C-B> equivale a hacer que el texto fluya de derecha a izquiera.
"De ahí que tampoco lo considere un atajo de teclado vital. Muchas veces en Vim
"queremos cambiar la configuración a algo que sea más de nuestro agrado, pero
"sin saberlo estamos perdiendo otros comandos muy interesantes. Es importante
"tenerlo en cuenta. Toda esta configuración permite ser un poco más versátil
"editando, aunque no funciona en terminales, imagino que a causa de que estas
"teclas las debe usar el sistema para otras cosas... (razón de más para apostar
"por guimode) esto es una alternativa a utilizar <C-O> (ejecuta un comando
"normal desde insert mode) y luego 'o' o 'A'. Utilizo estos mappeos por
"comodidad pero están lejos de ser obligatorios... muchas veces me encuentro
"haciendo <C-O>x para borrar un paréntesis autoinsertado que cierra... y
"encuentro <C-O>o mucho más ergonómico que <C-O>x
" }}}

" {{{ 5. VIM ES UN MUNDO!
""""""""""""""""""""""""""""""""""""""""
" NOTA:
" Vim nos obliga a pensar en inglés:
" es realmente más sencillo saber qué estás haciendo si piensas lo que la
" mnemónica de la tecla quiere decir (word, paragraph, insert, open, etc.)
" Cuando genero mappings adicionales también intento tener esta idea en cuenta,
" para así poder trabajar de una forma semántica sobre lo que quiero hacer.

" MOVIMIENTOS INTERESANTES
" ------------------------
" > [[      retrocede a la anterior función (detectada según sintaxis o por '{' '}')
" > ]]      avanza a la siguiente función (detectada según sintaxis o por '{' '}')
" > { y }   permiten moverse hasta la próxima línea en blanco
" > 27j     baja 27 líneas
" > w       palabra
" > 4w      4 palabras
" > b       principio de palabra o <-atrás una palabra
" > e       final de palabra
" > ge      final de la palabra anterior
" > zt      sitúa la linea actual en la parte superior de la pantalla
" > zz      sitúa la línea actual en el medio
" > zb      sitúa la línea actual en la parte inferior de la pantalla
" > CTRL-F  avanza una 'página'
" > CTRL-B  retrocede una 'página'
" > gd      busca la declaración de una palabra (la primera ocurrencia)
" > y sobre todo, aprender a usar 'f' y 't' y sus repetidores ';' y ','
" > (adelante y atrás)

" Un movimiento que está muy mal mapeado en un teclado español es el de 'follow tag', que sirve, sin ir más lejos, para moverse en los archivos de ayuda. Pero también para saltar a las definiciones y usos de una función de programación. Por defecto es <C-]> y es horrible, así que prefiero cambiarlo a <C-,>

nnoremap gl <C-]>

" Saltos:
" Interesante también es como, de los movimientos anteriores, los 3 primeros
" cuentan como un 'salto' mientras que los otros no...
" Las búsquedas, los satos por tags, también cuentan como saltos...
" son interesantes los saltos porque podemos listarlos:
"
"   :ju{mps}
"
" y podemos movernos por ellos con <C-O>(atrás) y <C-I>(delante) en modo normal
" como cualquier comando, puede ir precedido de un número para ejecutar más de
" un salto.

" LA BARRA DE ESTADO
" La barra de estado de Vim contiene una información un tanto pobre. He visto a
" personas que han hecho realmente barras de estado geniales, obras de arte,
" pero yo apuesto por un diseño bastante más minimalista y que tan solo incluya
" unos cuantos datos más que no el nombre de archivo y la posición en la que
" estamos...

set statusline=%<\  " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                       " número de buffer
set statusline+=%40F\                         " archivo y ruta (hasta 40 caracteres)
set statusline+=%h%m%r%w                      " flags(mod,ro,etc)
set statusline+=[%{strlen(&ft)?&ft:'none'},   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},  " encoding
set statusline+=%{&fileformat}]               " format (unix,dos)
set statusline+=%=                            " a la derecha
" lee sobre qué esta el cursor
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ 
set statusline+=[%04l,%04v]\                  " linea, columna
"
" MOVERSE POR MARCAS
" ------------------
" utilizar la tecla m y cualquier otro atajo después permite MARCAR una
" posición, esto es glorioso cuando trabajo con selecciones de texto amplias
" un ejemplo:
"   marco este espacio de teclado porque es por donde voy actualmente
" > mm
"   me muevo al principio y añado el título de la sección al índice
" > gg
" > 6j
" > o
" > <C-V><Esc>
"   ahora vuelvo a esta posición... cuál era el número de línea? no importa
" > `m
" tanto la tecla ' como ` permiten ir a una marca.
" yo he habilitado, además, distinción entre mayúsculas y minúsculas para
" tener más marcas
" Existen otras maneras de moverse muy eficientemente por largos espacios de
" texto sin tener que depender de la búsqueda, los veremos también

if has('viminfo')
  set viminfo=h,'100,f1 " permite tener 100 marcas y utilizar mayúsculas
endif
" además: un buen uso de marcas en este comando,
" que al abrir ficheros nos devuelve a la última línea en la que estuvimos
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" UTILIZAR MACROS
" ---------------
" otra función muy importante y que al principio me daba miedo es la
" utilización de macros... miedo he dicho? sí, no entiendo muy bien por qué
" pero pensaba que no lo requería mi trabajo y prefería repetir comandos de
" manera programática... pero cuando uno tiene que modificar texto puede ser
" muy útil utilizarlos... los macros se graban con la q y otra letra donde se
" almacena... se deja de grabar con q (así que 'qaq' por ejemplo elimina el
" macro grabado en la 'a') y luego se puede llamar al macro con @
" buenas ideas:
"   - acabar el macro con un movimiento vertical
"   - quizá un macro recursivo podría ser divertido para algo...
"   - no 'redibujar' la pantalla cuando ejecutamos un macro para no distraerse
"
" esto último vamos a hacerlo ya:
set lazyredraw

" UTILIZAR TAGS
" -------------
" Tener ctags instalado en la máquina debería ser una prioridad... y si es
" así, podemos generar archivos tags y navegar a través de ellos con vim como
" si se tratara de un super IDE...
" :ts{elect} permite saltar a la tag que queramos, completa con tabulador...
" :tnext y :tprev nos permite movernos...
nnoremap <Leader>ts :tselect<Space><C-D> nos permite llamar tSelect y
" mostrarnos una lista de autocompletado - impecable

" Esta función podría servir para generar las tags desde dentro de VIM
function! MakeTags() abort
  let command='ctags -R'
  let confirm = input(expand('%:h') . ' es este directorio correcto? y/n')
  if confirm == 'y'
    exec ':silent !' . command
  elseif confirm == 'n'
    echo 'utilice cd para navegar hasta el directorio raíz del proyecto'
    return
  endif
  echo 'Tags generadas.'
endfunction

" y generando este comando y un mappeo, podríamos tenerlo como acceso rápido
command! Maketags :call MakeTags()<CR>
nnoremap <leader>mkt :maketags<CR>

" Existen pocos atajos de teclado para las tags
" pero básicamente utilizaremos este:
" <C-]> go to definition (incluso a otro archivo)
" que hemos substituido por <C-,>
" también es útil el comentado anteriormente que lista todas las tags
"
" he hecho este comando para saltar rápido a tags tras escribir un par de
" letras:
nnoremap <leader>tj :tjump<Space><C-D>*

" INCREMENTAR/DECREMENTAR NÚMEROS
" -------------------------------
" esta es fácil y quizá no demasiado útil... pero se pueden incrementar los
" números que hayamos escritos incluso sin estar encima de ellos (el cursor se
" mueve al más cercano) con <C-A> y decrementar con <C-X>
" ejemplo:
"   func() {
"     var numero = 13;
"     return numero + 15 - 2;
"   } ^
"     |con el cursor aquí, <C-A> incrementaría el 15, para ir hacia el 2,
"      podríamos hacer f2<C-A>
"
"   si el ejemplo superior fuera
"   return numero +15-2
"   y quisiéramos modificar el 2, al darle a <C-A> obtendriamos 1...
"   pues lo interpretará como un número negativo: -2
"

" REGISTROS
" ---------
" Vim permite guardar texto en múltiples portapapeles, los llama registros
" esto es especialmente útil si queremos guardarnos distintos elementos. Los
" registros se corresponden a las letras del teclado.
" Hay además ciertos registros especiales, como un historial de los últimos
" diez cambios que ha sufrido.
" Para llamar a un registro en concreto, tanto para meter información en él,
" como para quitarla, debemos anteponer al comando unas comillas " y el
" carácter que vayamos a usar. Por ejemplo:
"
"   "syiw copiará la palabra bajo el cursor y la pondrá en el registro s
"   "sp   la pegará
"
" Desde el modo insertar (o desde la línea de comandos) para llamar a un
" registro en concreto debemos usar <C-R>
"
"   <C-R>* pega el registro normal
"   <C-R><C-W> pega la palabra donde esté el cursor
"   <C-R><C-A> pega la PALABRA donde esté el cursor
"
" Los registros especiales a los que me refería son los siguientes:
"   0-9 historial de últimos valores en el registro por defecto
"    _  el blackhole de aquello que realmente no queremos guardar
"    .  la oración actual (Entre mayúsculas y un punto)
"    #  el nombre de archivo y su ruta
"    :  el último comando
"    =  un registro especial para evaluar comandos
"
" Entonces si nos hemos equivocado y hemos cambiado nuestro registro sin
" querer a un nuevo texto y queremos pegar el anterior, sólo tendríamos que
" hacer "0p
"
" Un ejemplo de utilización de registros:
" cuando usamos c o x para cambiar texto o borrar en nuestra posición, se
" pierde lo guardado en el portapapeles de serie...
" para evitarlo, utilizo estos remaps que no cambian la funcionalidad, pero
" salvan este problema:
nnoremap x "_x
nnoremap c "_c
" lo que hacen es copiar al registro 'blackhole' el contenido eliminado.
" Se puede llamar al registro con
" :registers
"
" El registro = es especialmente interesante pues permite realizar cálculos
" rápidos o llamar a funciones e introducir su resultado
" un ejemplo:
"
"   12 + 5 =
"   400 + 123 * 78 =
"
"   ante este pequeño texto, podemos calcular los resultados pasándole el
"   cálculo al registro =
"   primero copiamos desde el inicio hasta antes del signo de igual
" > 0yt=
"   luego nos situamos después del igual y entramos en modo insert (importante)
" > A
"   entonces llamamos al registro = y le pasamos los datos
" > <C-R>=<C-R>*
"   le damos a Enter
"   voilà!
"   si tenemos que hacerlo en múltiples líneas, podemos crear un mapeo para
"   ello y utilizarlo:
"
" > nnoremap CALC 0"cyt=A<space><C-R>=<C-R>c<CR>
"
"   después, podemos seleccionar las líneas que queremos con V y aplicarle un
"   comando tal que así
"
" > :normal CALC
"
" podemos llamar también al registro a través del comando put
" por ejemplo:
"
"   :put =23 + 23
"   pondrá '46' en la siguiente línea
"
" Finalmente, ofrezco aquí algunos mappings para utilizar el registro con
" cierta inteligencia
" apretar * o # en modo visual permite buscar por la selección:
vnoremap <silent> * "sy/<C-r>s<CR>
vnoremap <silent> # "sy?<C-r>s<CR>

" De esta manera yo ya cuento con que en el registro 's' acostumbran a haber
" patrones de búsqueda anteriores (very nice).

" VENTANAS
" --------
" Vim ofrece dos modos de visualización: pestañas y ventanas
" ambos pueden combinarse y tienen, en realidad utilidades distintas.
" A mí me gusta considerarlo como una jerarquía:
" Cada pestaña tiene una disposición de ventanas
" Normalmente solo trabajamos con una pestaña, pero puede suceder que tengamos
" más de una abierta una vez nos adaptemos a ello.
" Sin embargo, recomiendo no abusar de las pestañas, ya que acostumbrarse a
" trabajar con la pantalla dividida trae muchas más ventajas
" Para abrir una nueva ventana tenemos los comandos split y vsplit
" además de sb para abrir un buffer en una nueva ventana
" las ventanas admiten los siguientes comandos
"  > <C-W>h    mueve a la ventana a la izquierda
"  > <C-W>l    mueve a la ventana a la derecha
"  > <C-W>j    mueve a la ventana inferior
"  > <C-W>k    mueve a la ventana superior
"  > <C-W>H    mueve la ventana hacia la izquierda
"  > <C-W>L    mueve la ventana hacia la derecha
"  > <C-W>J    mueve la ventana hacia abajo
"  > <C-W>K    mueve la ventana hacia arriba
"  > <C-W>o    cierra las demás ventanas
"  > <C-W>q    cierra la ventana actual
"  > <C-W>=    iguala el tamaño de las ventanas
"  > <C-W>+    extiende hacia abajo el tamaño de la ventana
"  > <C-W>-    extiende hacia arriba el tamaño de la ventana
"  > <C-W><    extiende hacia la izquierda el tamaño de la ventana
"  > <C-W>>    extiende hacia la derecha el tamaño de la ventana
" Algunos de estos comandos no los uso muy seguido, pero otros sí, por lo que
" he creado unos mapeos más eficientes para ellos

nnoremap <S-Left> <C-W>H
nnoremap <S-Right> <C-W>L
nnoremap <S-Up> <C-W>K
nnoremap <S-Down> <C-W>J
nnoremap <M-Left> <C-W>h
nnoremap <M-Right> <C-W>l
nnoremap <M-Up> <C-W>k
nnoremap <M-Down> <C-W>j
nnoremap <C-S-Left> <C-W><
nnoremap <C-S-Right> <C-W>>
nnoremap <leader>O <C-W>o
nnoremap <leader>= <C-W>=

" Si no mappeo el cerrar ventana es porque ya está a 2 teclas de distancia:
"  :q

" Las flechas pueden no ser la opción más popular para muchos, pero sí lo son
" para mí, que no tengo la mejor de las posturas. Una alternativa bien podría
" ser mapearlo directamente a <leader>hjkl y <leader>HJKL , no obstante, si
" bien eso lo haría bastante rápido, creo que ocuparía muchos espacios de
" mapeo valiosos

" Me he encontrado con casos en los que he tenido que copiar de un archivo a
" otro y para ello el tener dos ventanas ha sido muy útil.
" si el texto es largo, podemos marcar varias ventanas con un elemento
" llamado 'scrollbind' y entonces se moverán juntas.
"
"   :set scrollbind
" o también
"   :set scb
" tiene que hacerse en cada ventana que se quiera mover en sincronía
"
" De manera similar, también encuentro util la opción 'diff'
" Diff es una opción por defecto de Vim que permite comparar dos versiones de
" un mismo archivo. Vim permite ver los cambios en ambos archivos marcados y la
" parte de texto que permaneza igual quedaría oculta en pliegues.

" TABS
" ----
" Para las pestañas no tenemos comandos de teclado tan sencillos, sino que
" dependemos de comandos en su mayoría:
"
"   :tabnew
"   :tabonly
"   :tabclose
"   :tabmove
"   :tabnext
"
" Y una serie de comandos muy sencillos para movernos
"
"   gt     avanza a la siguiente tab o bien, si le damos un número, a esa.
"   gT     retrocede a la anterior tab
"   <C-W>T convierte la ventana actual en una tab nueva, sólo funciona si hay
"          más de una ventana
" He creado una serie de comandos para gestionar las tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
" este permite cambiar de orden una tab, hay que apretar enter al final
nnoremap <leader>tm :tabmove

" este permite movernos a la ultima tab en la que estuvimos, por si tenemos
" muchas abiertas
let g:lasttab = 1 "crea una variable con un valor por defecto
nnoremap <Leader>t<Leader> :exe "tabn ".g:lasttab<CR>
au! TabLeave * let g:lasttab = tabpagenr() " al irse de una tab, actualiza el
" valor de la variable

" BUFFERS
" -------
" Los buffers son todos los archivos abiertos por Vim
" Si queremos cambiar entre ellos rápidamente, podemos utilizar comandos como
"
"   :bnext
"   :bprev
"   :b#    --- permite ir al último buffer editado
"
" Importante saber eliminarlos también
"
"   :bdelete
"
" Con el comando
"
"   :ls
"
" Podemos listar todos los buffers abiertos
" Así que nos puede ser útil tener un mapping como este:

nnoremap gb :ls<CR>:buffer<space>

" con el que podemos listar los buffers y dejarnos la lista allí, para poder
" cambiar con un mero numeral y un enter.
" Otra aproximación podría ser utilizando el autocompletado con Tab:
nnoremap <leader>b :buffer<space>*
" escribiendo cualquier fragmento del nombre del buffer después y volviendo a
" apretar tab, Vim intentará autocompletar
"
" Muchas veces me sucede que quiero abrir otro buffer pero en una ventana
" partida...
nnoremap <leader>vb :ls<CR>:vertical sb<Space>
" este comando, un tanto más largo, es comparable al primero
" al utilizar ':vertical sb' en vez de ':buffer' le decimos a vim que lo abra
" (obviamente, el vertical es opcional)
" en un split vertical (a la derecha)
" otra opción sería algo así:
cnoremap <C-S> <Home>vertical s<End>
" para maximizar compatibilidad con terminales y mappings, utilizo la
" combinación <C-S> y luego la combinación de teclas. En este caso, <C-S> <C-S>
" nos permitiría poner este texto al principio de manera dinámica y luego
" podemos aún completar el nombre/número de buffer y apretar enter

" Creo que uno de los que más uso es el alternar entre un buffer y el
" anterior, así que también le he hecho un mappeo rápido pues :b# es bastante
" horrible:

nnoremap gB :b#<CR>

" El comando por defecto para esto es CTRL-6 ... no especialmente complicado,
" pero prefiero tener otro mapping

" SNIPPETS CON EL COMANDO :read TODO
"
"}}}

" {{{ 6. BUSCANDO ARCHIVOS, LINEAS, PALABRAS...
"""""""""""""""""""""""""""""""""""""""""""
"
" UN NAVEGADOR DE ARCHIVOS??
" --------------------------
" La función por excelencia de los IDEs y editores más modernos... un navegador
" de proyecto/ficheros
" Vim viene con uno, llamado Netrw, si se instala con la opción +Files
" Mucha gente prefiere utilizar un plugin distinto como NERDTree... la verdad
" es que Netrw no es que sea el mejor explorador del mundo y parece harto
" complejo para algunas cosas. Pero me ganó el corazón al dejarme conectar por
" ssh y navegar el servidor.
"
"   :Explore
"   :Vexplore
"
" o bien llamar a vim sobre una carpeta cuando lo arrancamos (terminar en /)
"
"   $ vim src/
"   $ vim ftp://user@server.domain.com//public/
"
" abrirá el navegador...
" Netrw tiene muchos comandos pero los que más acabo usando son estos:

"   <CR>  Entra en el directorio, abre el archivo para editar
"   <Del> Intenta borrar un directorio
"   c     Cambia el directorio de trabajo al del archivo
"   a     Muestra/Oculta archivos ocultos
"   d     Crea una carpeta
"   D     Intenta borrar un archivo
"   i     Cambia el tipo de vista
"   mf    marcar un archivo
"   md    borrar archivos marcados
"   mt    marca un directorio como 'target'
"   mm    mueve archivos marcados al 'target'
"   mz    descomprime archivos marcados
"   mu    desmarcar todos los archivos
"   o     abre archivo en un split horizontal
"   p     preview del archivo
"   r     invierte el orden del listado
"   s     escoger el parámetro que ordena el listado (tamaño, nombre, etc)
"   R     cambiar nombre
"   v     abre archivo en split vertical
"   x     ejecuta archivo con programa asociado
"   %     crea un archivo nuevo

" Parece más que suficiente para la mayoría de casos... de hecho, la verdad es
" que no utilizo ni la mitad de estos comandos. Pero sí es importante
" configurar un poco la apariencia por defecto de netrw y crearle un acceso de
" teclado adecuado...
let g:netrw_banner=0 " desactivar el 'banner' informativo de la parte superior
let g:netrw_altv=1 " abrir los splits a la derecha siempre
let g:netrw_browse_split = 0 " por defecto abrir netrw en la misma ventana y
                             " abrir los archivos en la ventana donde estaba nt
let g:netrw_liststyle=3 " tipo de vista por defecto -> Tree
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\\s\s\)\zs\.\S\+' "evitar archivos ocultos
let g:netrw_winsize = 35 " ancho de ventana
let g:netrw_localrmdir='rm -r' " permite borrar directorios no-vacíos

" Borrar los buffers de netrw si ya no son visibles, para evitar acumulación
" de navegadores
autocmd FileType netrw setl bufhidden=wipe

" Una función que recorre los buffers para ver si ya hay un netrw abierto,
" evitando que se abran más de una ventana de netrw
let g:NetrwIsOpen=0

function! ToggleNetrw() abort
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i
      endif
      let i-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
  endif
endfunction

" Y entonces, activar netrw con <Leader>ex
nnoremap <Leader>ex :call ToggleNetrw()<CR>

" FuzzyFinding para archivos
"
" La razón por la que uso tan poco netrw es que en general, intento acceder a
" los archivos de una manera más rápida que no recorriendo todo el arbol de
" directorios... en general prefiero poder escribir un trozo del nombre de
" archivo y pedirle a vim que intente autocompletar... Vim no parece preparado
" para hacer este tipo de cosas, pero nada más lejos de la verdad:

set path+=**/* " con este parámetro de configuración, añadimos a la variable
" path el valor recursivo desde la posición actual. Esto quiere
" decir que si estamos situados en la raíz de un árbol de
" directorios, buscaremos en todo lo que haya en su interior...
" Cuidado con intentar después buscar estando en la carpeta
" home y similares!!!
nnoremap <leader>f :find *

" A continuación, preparamos el menú de autocompletado a la mejor función
" posible, Vim llama este menú wildmenu, supongo porque acepta comodines
" (wildcards) y autocompleta...
"
" Entonces, cuando estemos en modo comando, no importa si queremos listar los
" comandos disponibles, ver los buffers o abrir un nuevo archivo, siempre
" podemos escribir una parte del resultado y apretar <Tab> que vim intentará
" autocompletarlo. Además, acepta asteriscos como caracter, lo que permite
" hacer la búsqueda aún más dinámica.

set wildmenu wildmode=list:longest
" el modo list:longest implica que primero mostrará todos los matches y después
" completará lo que hayamos escrito hasta donde acaba la parte común
" Después, solo hará falta marcar un gran número de archivos a ignorar para
" acelerar el proceso:
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.luac " Lua byte code
" compiled object files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.dat,*.class,*.zip,*.rar,*.7z
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
" images
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
" node modules y similar
set wildignore+=*/node_modules/*,*/bower_components/*
" git
set wildignore+=.git/*

" Ligado a este tipo de búsqueda está la idea de poder buscar no archivos,
" sino EN los archivos. Vim puede hacer esto con su comando interno VimGrep o
" bien también utilizando grep desde el sistema...
" Yo he sustituido grep por rg, que es mucho más rápido (una herramienta que
" recomiendo!!!) y que tiene una sintaxis más sencilla. Para más información:
" http://github.com/BurntSushi/ripgrep
"
" Si existe rg...
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

  " --column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  " --color: Search color options

  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag") " o si existe su hermano menor y más famoso Ag
  set grepprg=ag\ --nogroup\ --nocolor\ --smart-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Especialmente recomendable en windows, donde el comando find es basura.
" si no encontrara ni rg ni ag, entonces vim utilizaría grep o find

" Bien, cómo utilizar grep?
" Al utilizar :grep <patrón>
" los resultados 'pueblan' la lista de errores, la llamada QuickFix Window.
"
" si utilizamos el comando :grep <patrón> a secas, se nos abrirá el primer resultado,
" si bien se nos mostrarán todos... es más útil acabar el comando con un !
" para que no salte a ningún resultado de forma automática:
"
"   :grep! 'búsqueda' | lopen
"
" la parte final obliga a grep a utilizar la 'location list' en vez de la
" quickfix window... en principio esto no genera ninguna diferenciación, solo
" que las location lists son individuales, una por buffer, mientras que la
" quickfix window es global... si realmente preferimos la quickfix window,
" deberíamos usar :copen en vez de :lopen
"
" He creado una función para buscar rápido:
function! MySearch() abort
  let grep_term = input("Pattern: ")
  if !empty(grep_term)
    execute 'silent lgrep!' grep_term
    " silent sirve para que no nos muestre el primer mensaje de la consulta
  else
    echo "No pattern provided"
  endif
  redraw!
endfunction

" y con un comando y un mappeo consigo que sea accesible la búsqueda
command! Search call MySearch()
nnoremap º :Search<CR>

" Con este comando podemos incluso permitirnos buscar a través de documentos
" todas las ocurrencias de la palabra actual, como si se tratara de * pero a
" través de archivos:

" grep-find:
nnoremap <Leader>gf :Search<CR><C-R><C-w><CR>

" ARCHIVOS RECIENTES
" Otra herramienta habitual de los programadores es querer abrir los archivos
" recientes... para esta opción, vim no parece ser especialmente efectivo, si
" bien la trae ya incorporada para saltos rápidos:
nnoremap <leader>F :bro oldfiles<CR>
" cuando la lista se desplega, salen los últimos 100 archivos en orden
" cronológico de apertura y, al final, vim nos pide un número para abrir el
" archivo indicado... no está nada mal para ser una función de serie y sin
" más... para mejorarlo, podemos intentar algo como esto:
" Podemos utilizar simplemente :oldfiles para listarlos, sin ir a ninguno de
" ellos y posteriormente pasarle a vim el número de archivo con un comando
nnoremap <leader>F :oldfiles<CR>:e #<

" el comando anterior carga la lista numerada de archivos y luego llama al
" comando :e{dit} con un prefijo que se refiere a los archivos recientes. Sólo
" con poner el número después nos moveríamos a dicho archivo

command! MostRecent vnew +setl\ buftype=nofile | 0put =v:oldfiles
      \| nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>

" y entonces
nnoremap <leader>F :MostRecent<CR>
" nos abrirá otro split con los nombres de todos los archivos recientes de
" manera que podemos buscar en la lista con tranquilidad y como si fuera un
" buffer normal, en el momento en que apretamos enter, se nos abrirá el
" archivo en el mismo split (excelent!)


" LA LISTA ARGS
"
" cuando ejecutamos vim desde consola, se le pueden pasar más de un archivo para que los abra.
" Como en cualquier comando de consola, lo que se le pasa a un comando se llaman Argumentos.
" Vim acepta cualquier número de argumentos, que pueden listarse con
"   :args
"
" Si tenemos múltiples archivos abiertos que hayamos abierto por medio de uno
" de los comandos anteriores o a través de
" :edit
" :vs
" :sp
"
" estos archivos estarán cargados como 'buffers' pero no como 'args'
" podemos agregarlos a la lista args con el comando
"
" :argadd
"
" Podemos entender la lista args como una sublista de la de buffers.
" Podemos pasar de un arg al siguiente con :next y volver con :prev
"
" La verdad es que no utilizo mucho la lista args, pero puede servir para
" mantener una sublista de ficheros en los que queramos hacer operaciones
" concretas.
"
"   :argdo <comando>   permite ejecutar un comando en todos los args
"
" Otras combinaciones posibles es hacerlo en la lista de buffers
"
"   :bufdo
"
" O en las ventanas abiertas
"
"   :windo
"
" Sin embargo, para este tipo de situaciones, como buscar y reemplazar en
" diversos archivos, Vim ha implementado un modo de hacerlo de manera más
" sencilla si tenemos poblada la QuickfixList o la LocalList, tal y como lo
" hace grep o más comandos que veremos. Desde la versión 7.4 tenemos el comando
"
"   :ldo
"   :cdo
"
" para trabajar sobre estas ventanas rápidas
"

" PREVIEW
"""""""""
" También podemos abrir una ventana pequeña, como de consulta, para
" previsualizar un archivo y ver si es el correcto o no.
" El comando
"
"   :ped
"
" nos permite abrir esta ventana.
" Sólo puede haber una abierta a la vez.
"
"   <C-W>z  cierra la ventana de preview sin necesidad que estemos sobre ella.
"
" útil para pequeñas consultas, sobre todo si lo combinamos con Tags generadas:
"
"   :ptag
"
" abre la preview window con la definición de una tag y
"
"   :ptnext
"   :ptprev
"
" nos permite navegar por las tags.
"
" }}}

" {{{ 7. BUSCAR, SUBSTITUIR
"""""""""""""""""""""""
"
" BUSCAR: ACCESIBLE
" Buscar tiene un papel fundamental para este programa. Es casi la mejor
" manera de moverse y utiliza expresiones regulares con 'flags' al final de
" manera nativa.
"
" Buscar está pensado para estar al lado de la tecla shift derecho en teclados
" ingleses y Buscar hacia atrás en la combinación de estas dos teclas.
" En el teclado español esta disposición desaparece y se vuelve mucho menos
" accesible el buscar (Shift + 7)
" por ello, cambio la tecla de referencia a '-' y '_' :
nnoremap - /
nnoremap _ ?


" LA 'MAGIA' DE VIM
" Vim viene con el modo 'magic' activado por defecto, eso implica que ciertos
" caracteres especiales - básicamente '.', '*' y '[' y ']'
" se corresponden a su valor de expresión regular
" otros caracteres típicos de expresión regular tienen que 'escapearse' con '\'
" es el modo habitual de buscar en vim, pero puede considerarse un poco
" confuso cuando uno se acostumbra a expresiones regulares, pues sólo la mitad
" de los símbolos funcionan como en grep...
" podemos activar el modo 'very magic' para convertir todos los caracteres
" excepto las letras en lo que signifiquen en expresiones regulares, para solo
" tener que escapearlos cuando tengamos que buscarlos como literales
"
" ejemplo:
" buscar color y valor:
" /\<\(co|va\)lor\>                  <-- Magic
" /<(co|va)lor>                      <-- Very Magic
"
" Desafortunadamente no podemos utilizar Very Magic siempre activo por
" defecto, siempre hemos de incluirlo en la búsqueda con \v al principio
" Así pues, puede ser conveniente remappear la búsqueda normal a Very Magic,

nnoremap - /\v
nnoremap _ ?\v
" recordemos que antes mappeé a '-' la búsqueda por accesibilidad. De este
" modo, la '/' aún nos haría una búsqueda tradicional si la necesitáramos.
"

" tener un archivo de referencia
" Los patrones regex son realmente complicados a veces y no puedo contar la de
" veces que he tenido que ir a mirar uno nuevo en internet... si bien aprender
" es importante, es un largo y tedioso camino y no está demás tener un archivo
" con referencias a cosas que ya se hayan hecho y sean útiles. Yo he ido
" recopilando de un par de genios y tengo un archivo que me guardo en la
" carpeta de vim, para poder cargarlo en memoria y buscar algún patrón:

" help-search:
nnoremap <leader>hs :vs g:vim_at_user_home/vimtips.txt<CR>

" REEMPLAZAR
"
" La función de reemplazar es un comando que admite rangos, sino actúa sólo
" sobre la primera línea. También admite 'flags' después y es especialmente
" útil la 'g' para afectar a todas las ocurrencias y no solo a la primera.
"
"   :10,15s/foo/bar/g
"
" reemplazaría todos los 'foo' por 'bar' en las líneas 10 a 15
"
" si tenemos una selección hecha, el comportamiento de Vim es utilizarla como
" rango sobre el que actúe la función. Si en vez de eso queremos reemplazar el
" texto que tenemos seleccionado, podemos hacer un pequeño truco:

" replace:
vnoremap <silent> <leader>rp  "sy:%s/<C-r>s//g<Left><Left>

" También puede ser útil querer reemplazar de manera directa la palabra que
" tengamos bajo el cursor en un momento dado:

" replace-word under cursor:
nnoremap <Leader>rw :%s/\<<C-R><C-W>\>//g<LEFT><LEFT>
" replace-WORD under cursor:
nnoremap <Leader>rW :%s/\<<C-R><C-A>\>//g<LEFT><LEFT>

" BÚSQUEDA CON PREVIEW
"
" Quizá nos resulte interesante hacer una búsqueda con menos complicaciones de
" patrones pero en la que no tengamos que saltar
"
" podemos poblar una lista dinámica con resultados con el comando
"
"   :il /<patrón>
"
" la ventaja de utilizar esta opción es que quizá no necesitemos refinar tanto
" nuestro patrón, pues veremos todas las ocurrencias en su contexto, con lo
" que podremos saltar a cualquiera de ellas con facilidad, escribiendo
" posteriormente el número de línea.
" Además, :il no busca en los comentarios
"
nnoremap <leader>- :il/<space>

" Existen combinaciones adicionales para buscar directamente la palabra bajo
" el cursor en una lista, una excelente manera de tener un preview cuando
" buscamos funciones o todos los usos de una variable:
"
"     [I  busca y lista desde el principio del documento todas las apariciones
"         de la palabra bajo el cursor
"
" Puede parecer un poco incómodo, teniendo en cuenta que es una mejor versión
" de '*'
nnoremap <leader>* [I:
" el ':' al final es para dejarnos escoger directamente la línea al acabar el
" listado.
"
" Si queremos poblar la local-window en vez de seleccionar por número de
" línea, es mejor que utilicemos un atajo un poco más complejo, con una
" función:

function! Turbo_asterisk()
  redir => output
  silent! exec join(['ilist', expand('<cword>')], ' ')
  redir END
  let lines = split(output, '\n')
  if lines[0] =~ '^Error detected'
    echomsg 'No se ha podido encontrar la palabra'
    return
  endif
  let [filename, line_info] = [lines[0], lines[1:-1]]
  let loclist_entries = map(line_info, "{
        \ 'filename': filename,
        \ 'lnum': split(v:val)[1],
        \ 'text': getline(split(v:val)[1])
        \ }"
        \ )
  let win_number = winnr()
  call setloclist(win_number, loclist_entries)
  lwindow
endfunction

nnoremap <leader>* :call Turbo_asterisk()<CR>"

" podemos incluso hacer una similar para el mappeo anterior...

function! Turbo_il(pattern)
  redir => output
  silent! exec join(['ilist', a:pattern], ' ')
  redir END
  let lines = split(output, '\n')
  if lines[0] =~ '^Error detected'
    echomsg 'No se ha podido encontrar la palabra'
    return
  endif
  let [filename, line_info] = [lines[0], lines[1:-1]]
  let loclist_entries = map(line_info, "{
        \ 'filename': filename,
        \ 'lnum': split(v:val)[1],
        \ 'text': getline(split(v:val)[1])
        \}"
        \)
  let win_number = winnr()
  call setloclist(win_number, loclist_entries)
  lwindow
endfunction

" requerirá un comando para pasarle la búsqueda:
command! -nargs=1 Tilist exec printf('call Turbo_il(%s)', string(<q-args>))

" y remapear:
nnoremap <leader>/ :Tilist<space>
" }}}

" {{{ 8. PLUGINS MINIMALISTAS Y VALIOSOS
""""""""""""""""""""""""""""""""""""
"
" Hasta ahora hemos explorado lo que Vim puede hacer por sí solo y sin
" necesidad de ningún extra. El programa ofrece a su manera la mayoría de
" opciones que tiene un editor moderno mucho más pesado. Sin embargo, podemos
" incluir otras funcionalidades que le faltan o bien ampliar aún más las
" capacidades del editor con ciertos plugins.
"
" Al principio de mi andadura por Vim, utilizaba muchos plugins, pues
" desconocía muchas de las funciones que ya ofrece el programa.
" Pero con ellos activos, la verdad es que el programa no era tan rápido al
" arrancar y, como buen maniático de la eficiencia, no podía soportar la idea
" de que Vim tardara un par de segundos en arrancar. Además, la mayoría de
" plugins los tenía por recomendaciones y no por realmente darme cuenta que
" los necesitaba.
"
" Lo primero que uno tiene que conseguir es un gestor de plugins, ya que vamos
" a instalar plugins, el primero y más importante que sea el que se encarga de
" instalarlos. Todos los gestores de paquetes que he probado me han parecido
" excelentes, sin embargo la configuración de vim-plug me parece la mejor,
" tanto por sus comandos como por su capacidad de ejecutar acciones
" adicionales si es que estas hicieran falta (algunos plugins requieren
" compilarse, por ejemplo)
"
" También es bueno tener en cuenta que no siempre podremos instalar los
" plugins, según nuestro nivel de permisos en el sistema en que estemos, por
" lo que es bueno aislar todo lo que tenga que ver con ellos con un
" condicional.
" NOTA: A continuación se encuentra una lista de plugins que yo considero
" muy útiles y ligeros. Me gustaría dejar claro que esta preferencia es
" subjetiva.
"
" Toda la instalación de Vim-Plug está cubierta en este mismo archivo, solo
" hace falta tener curl instalado. Si no se tiene curl, entonces mejor
" descargarlo y colocarlo manualmente.
" Instalación de Vim-Plug >> mirar en https://github.com/junegunn/vim-plug

" Si plug no está, instálalo (antes que hacerlo automático, dejarlo en un
" comando está bien por si tenemos problemas de permisos)
"
function! InstallPlug(win)
  if a:win == 1
    if empty(glob($HOME . '/vimfiles/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs " importante tener curl
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      exec PlugInstall --sync | source $MYVIMRC
      return
    endif
  endif
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    exec PlugInstall --sync | source $MYVIMRC
  endif
endfunction

command! InstallPlug call InstallPlug(has('win32'))

" Se establece la carpeta de los plugins según si es windows o unix:
if filereadable($HOME . '/vimfiles/autoload/plug.vim') 
      \|| filereadable($HOME . '/.vim/autoload/plug.vim')
  if has('win32')
    call plug#begin('$HOME/vimfiles/plugged')
  else
    call plug#begin('~/.vim/plugged')
  endif

  Plug 'tpope/vim-repeat' " permite repetir comandos personalizados
  " Repetir comandos complejos puede ser especialmente útil en algunos casos
  " Para ver un ejemplo muy sencillo:
  " http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
  "
  " Básicamente, siguiendo esta fórmula:
  "
  "   nnoremap <silent> <Plug>NoMbReArBiTrArIo teclas-apretadas
  "     \:call repeat#set("\<Plug>NoMbReArBiTrArIo")<CR>
  "   nmap combinacion-del-remap <Plug>NoMbReArBiTrArIo
  "
  " Un mapping aceptará repeticiones en su totalidad.

  Plug 'tpope/vim-commentary'
  " permite comentar texto según sintaxis con el comando gc{movimiento}
  " acepta todos los movimientos de vim de manera nativa y el plugin es
  " mínimo, super integrado

  Plug 'tpope/vim-surround'
  " el plugin más útil de cuantos haya visto. Es una solución alternativa al
  " problema de los paréntesis autocerrados, está super integrado con vim
  " nativo y básicamente permite añadir, substituir o eliminar caracteres a
  " los límites de cualquier sección de texto.
  " Uso:
  " yssb    rodea linea de parentesis (yank substline brackets)
  " ds"     elimina comillas de alrededor (delete surrounding ")
  " cs"<q>  substituye comillas por <q> ( change surrounding " for <q> )
  " ysiw]   rodeará una palabra de brackets ( yank substinnerword ] )
  " S       en visual mode permite rodear con cualquier input
  "
  " También remarcar que se pueden usar objetos textuales más grandes que iw
  " como el párrafo, las comillas ('ysi")') o incluso la t de tags para xml...
  "
  " Estos comandos también se pueden usar para cambiar texto o borrar (diw, cib)
  " Y no hace falta estar 'dentro' del objeto textual, si no estamos dentro,
  " Vim avanzará hasta el primer objeto a la derecha
  "
  " añado a los caracteres de serie ¡ y ¿ para escribir preguntas y
  " exclamaciones gramaticalmente correctos
  let g:surround_{char2nr("¡")} = "¡\r!"
  let g:surround_{char2nr("¿")} = "¿\r?"

  Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
  " para integrar el control de versiones a Vim y tener indicadores visuales
  " en la barra a la izquierda. Veamos un poco de configuración:
  " --------- fuGITive -----

  Plug 'tpope/vim-abolish'
  " Pequeño plugin que permite corregir errores de escritura y mejora el
  " funcionamiento del comando de substitución:
  " USO:
  " :Abolish pattern-to-substitute substitution
  " pattern might be composed like this
  " :Abolish teh the
  " :Abolish colour{,s,ed,ing} color{}
  " :Abolish {hon,col}our{,s,ed,ing} {}or{}
  " or in case of searches
  " :S /{insert,visual,command}_mode
  " matches INSERT_MODE, visual_mode & CommandMode
  "
  " para más info, ver:
  " http://vimcasts.org/episodes/smart-search-with-subvert/
  " http://vimcasts.org/episodes/supercharged-substitution-with-subvert/
  " http://vimcasts.org/episodes/enhanced-abbreviations-with-abolish/
  "
  " Además ya incluye ciertas modificaciones útiles para programadores,
  " principalmente el coerce-case:
  " Want to turn fooBar into foo_bar?
  " Press crs (coerce to snake_case).
  " MixedCase (crm),
  " camelCase (crc),
  " snake_case (crs),
  " UPPER_CASE (cru),
  " dash-case (cr-),
  " dot.case (cr.),
  " space case (cr<space>),
  " and Title Case (crt)
  "
  " are all just 3 keystrokes away. These commands support repeat.vim.

  Plug 'jiangmiao/auto-pairs'
  " Para cerrar automáticamente paréntesis, comillas y similares... es un
  " plugin ligero y que permite trabajar con una cierta mejora de velocidad...
  " Sin embargo creo que no es necesario utilizarlo en muchos casos, ya que
  " surround hace un trabajo excelente...
  " Realmente este plugin es uno de los causantes de que haya creado <C-Enter>
  " y <S-Enter> como comandos, para evitar tener que cerrar yo mismo las
  " comillas o los paréntesis y convertir en inútil este plugin.
  " Para arreglarlo, me preparo un mapping para activar o desactivar el plugin

  " Por lo visto autopairs contiene una variable para marcar con qué tecla se
  " activa o desactiva el plugin...
  " let g:AutoPairsShortcutToggle='tecla'
  " esto parece no estar funcionando o no funcionar siempre, así que por si acaso:
  nnoremap <C-ç> :call AutoPairsToggle()<CR>  
  " si este mapeo no funciona, podemos substituirlo por su código máquina, el cual podemos insertar a través de CTRL-V:
  nnoremap  :call AutoPairsToggle()<CR>

  Plug 'justinmk/vim-sneak'
  " Este plugin es quizá el más pesado que cargo y es bastante ligero en
  " cualquier caso. Básicamente sneak proporciona una mejor versión del
  " comando f, pues acepta 2 letras en vez de una y nos permite saltar líneas.
  "
  " Si nos encontramos con la línea:
  "
  "   El Veloz murciélago hindú comía feliz cardillo y kiwi.
  "   La cigüeña tocaba el saxofón detrás del palenque de paja.
  "
  " y yo hiciera
  "
  "  > sca
  "
  " me movería hacia 'cardillo'
  " y apretando ; avanzaría hasta 'tocaba.'
  " con , volvería a 'cardillo'
  "
  " Existen alternativas, para o bien hacer más potentes la t y la f que ya
  " trae vim o bien para ofrecer aún más funcionalidad, como es el caso del
  " famoso plugin EasyMotion
  " Creo que sneak está en un buen intermedio en cuanto a potencia/tamaño y he
  " de decir que lo uso en muchos menos casos de los que cabría imaginar.

  Plug 'godlygeek/tabular'
  " Otro excelente plugin que permite formatear el texto con gran velocidad y
  " personalización. Este se basa en comandos de buscar
  " Me remito a otro VimCast para verlo en acción:
  " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
  "
  " Básicamente llamamos al comando :Tab y le pasamos el caracter por el que
  " queremos indentar de manera ordenada... o bien le pasamos una expresión
  " regular entre /barras/
  "
  " Y engancho esta genialidad:
  " A Tim Pope function for tables automatically realigning when using pipe for
  " separations:
  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

  function! s:align() abort
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction"

  "Automáticamente mientras escribimos, si queremos hacer una tabla, solamente
  "con separar los valores con | se autoformateará sola.

  " }}}

  " {{{ 9. EXTRA PLUGINS MÁS ESPECÍFICOS
  """"""""""""""""""""""""""""""""""

  " COLORES
  " -------
  " Sobre todo para la versión GUI, me gusta establecer alguna combinación de
  " colores menos estridente y que distraiga menos. Si bien darkblue, desert y
  " koehler son relativamente legibles, prefiero un menor nivel de contraste
  " siempre que pueda:
  Plug 'dennougorilla/azuki.vim'
  Plug 'whatyouhide/vim-gotham'
  Plug 'mbbill/vim-seattle'
  Plug 'clinstid/eink.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'morhetz/gruvbox'

  " EMMET
  " -----
  "  Tener capacidad para trabajar con Emmet en Vim agiliza mucho el diseño web:
  "  permite escribir la mitad y conseguir los mismos o mejores resultados
  "  incluso. Google lo recomienda...
  "  A este magnífico plugin yo sólo le añadiría un mejor atajo de teclado para
  "  llamarlo, pues el que tiene por defecto (<C-Y>,) es demasiado complicado.

  Plug 'mattn/emmet-vim'

  " FZF
  " ---
  "  Utilizo también el programa fzf en la consola... utilizar su plugin en vim es casi una obligación y convierte en absurdos la mayoría de mappings anteriores:
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

  " ALE?
  " ----
  "  TODO: Aún no lo he probado
  "

  " }}}

  " {{{ 10. DICCIONARIOS DE SINTAXIS
  " El último apartado a tratar tiene que ver con los diccionarios de sintaxis
  " que pueden ampliar las funciones de autocompletado de Vim. Existen realmente
  " un enorme número de plugins que evalúan la sintaxis o que amplían el
  " diccionario interno de Vim con mayor número de comandos. Podemos intentar
  " escoger tan solo aquellos que necesitemos, pues generalmente un programador
  " no trabaja en demasiados lenguajes distintos. No obstante, existe un
  " empaquetado creado a partir de gran parte de los plugins de sintaxis que, si
  " bien ocupa un poco de espacio en disco, es realmente impecable en su
  " funcionamiento y no carga todos los plugins sino solo los que se necesiten
  " según el tipo de archivo.
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go'

  call plug#end()
  " Al final de esta sección, cerramos el condicional que protege de errores por
  " no poder instalar plugins:
endif
" }}}

" config de fugitive y gitgutter
if exists(":Git")
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gr :Gremove<CR>
  nnoremap <Leader>gl :Glog<CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gm :Gmove
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gp :Ggrep
  nnoremap <Leader>gR :Gread<CR>
  nnoremap <Leader>gg :Git
  nnoremap <Leader>gd :Gdiff<CR>

  "------  Git Gutter Options ------
  "Disable <Leader>h* commands as they slow down movement
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 999
  if executable("rg")
    let g:gitgutter_grep = 'rg'
  endif
endif

if has('gui_running')
  color seattle " preferencia personal
endif
" Tamaño de la ventana y posición:
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Clear'],
      \ 'hl':      ['fg', 'String'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Un comando para llamar a fzf como grepper utilizando RG
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
      \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
      \   <bang>0)

" Esta es quizá la única función para la que no venía preparado de serie fzf.vim
" Ahora sobreescribo los mappeos anteriores por estos:
"
" En el caso de no tener disponible fzf, nada de esto debería ser mappeado,
" para que perduren las configuraciones anteriores:

if !&diff
  augroup PluginMapping
  autocmd!
  autocmd VimEnter * call Maps_Plugins()
  augroup end
endif

function Maps_Plugins()
  if exists(":Emmet")
    exec "inoremap <C-Space> <Esc>:call emmet#expandAbbr(3,'')<CR>i"
  endif
  if exists(":FZF")
    exec 'nnoremap <leader>b :Buffers<CR>'
    exec 'nnoremap <leader>f :Files<CR>'
    exec 'nnoremap º :Rg<space>'
    exec 'nnoremap <leader>F :History'
    exec 'nnoremap <leader>ts :Tags'
  endif
  if exists(":Git")
    "------  Git Gutter Options ------
    "Disable <Leader>h* commands as they slow down movement
    let g:gitgutter_map_keys = 0
    let g:gitgutter_max_signs = 999
    if executable("rg")
      let g:gitgutter_grep = 'rg'
    endif
  endif
endfunction
