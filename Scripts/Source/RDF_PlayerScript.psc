Scriptname RDF_PlayerScript extends ReferenceAlias
{Player script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

RDF_InitScript Property RDF_Init Auto
{Reanimate Fix Quest script.}

Actor Property PlayerRef Auto
{The player.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnPlayerLoadGame()

  Debug.TraceAndBox("Player Has Loaded Game")
  RDF_Init.AddReanimateFixPerk()

EndEvent
