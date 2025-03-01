package require sqlite3
package require Iwidgets
package require Img
wm geometry . 400x400
#---------------------------------------------------------------------------------------
set arquivo [file normalize [file dirname $::argv0]]
sqlite3 db [file join $arquivo "db" "database.db"]
source [file join  $arquivo "tabelas.tcl"]
#---------------------------------------------------------------------------------------
::oo::class create agenda {
  variable calendario_icon
      constructor {}\
      {
      #setando variaveis do objeto
      global arquivo
#     set calendario_icon [image create photo -file [file join $arquivo "imagens" "calendario_icon.png"]]

      #setando widgets

      frame .direita
      frame .esquerda
      text .esquerda.display
      iwidgets::calendar .direita.calend
      frame .toolbar -relief ridge -border 1
      entry .toolbar.tarefa_ent
      button .toolbar.enviar -text "enviar" -command [list [self] submit]
      #colocando os widgets
#       pack .testo -fill both -expand 0

      pack .toolbar -side bottom -fill x
            pack .toolbar.enviar -side right
            pack .toolbar.tarefa_ent  -fill both -side left -expand 1

      pack .direita -side right -fill both
            pack .direita.calend -side top
      pack .esquerda -side left -fill both
            pack .esquerda.display -fill both

      bind .esquerda.display <Button-1> break
      bind .direita.calend <Button-1> {[list [self] pegar_eventos]}
      }
            method pegar_eventos {} {
            puts ola
            set d [.direita.calend get]
            db eval {SELECT * FROM eventos WHERE data = $d} resuntado {puts "$resuntado(tarefa), $resuntado(data)" }

            }
            method submit {} {
                  set t [.toolbar.tarefa_ent get]
                  set d [.direita.calend get]
                  db eval "INSERT INTO eventos (tarefa,data) VALUES ('$t' , $d)"
                  .toolbar.tarefa_ent delete 0 end
                  puts ola
            }
}




# carrega os arquivos

source [file join $arquivo "dia.tcl"]
#cria os objetos
dia new
agenda new

