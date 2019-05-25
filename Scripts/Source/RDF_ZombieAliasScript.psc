Scriptname RDF_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; IMPORTS
;
;-------------------------------------------------------------------------------

Import RDF_Lib

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

RDF_AliasController Property Controller Auto
{Reanimate Disintegration Fix alias controller script.}

Actor Property PlayerRef Auto
{The player.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fUpdateDelay = 1.0

Float fOnDyingDelay = 0.5

Float fWait = 0.01

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

State Dying

  Function UntrackZombie(Actor Zombie)
  EndFunction

  Event OnUnload()
  EndEvent

  Event OnCellDetach()
  EndEvent

  Event OnUpdate()
  EndEvent

  Event OnDying(Actor Killer)
  EndEvent

  Event OnDeath(Actor Killer)
  EndEvent

EndState

Function UntrackZombie(Actor Zombie)

  GoToState("Dying")

  Bool Done = Controller.UntrackZombie(Self, Zombie)

  While !Done
    Utility.Wait(fWait)
    Done = Controller.UntrackZombie(Self, Zombie)
  EndWhile

  GoToState("")

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUnload()

  RegisterForSingleUpdate(fUpdateDelay)

EndEvent

Event OnCellDetach()

  RegisterForSingleUpdate(fUpdateDelay)

EndEvent

Event OnUpdate()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie
    If ZombieHasExpired(Zombie)
      UntrackZombie(Zombie)
    Else
      MoveZombieToPlayer(Zombie, PlayerRef)
    EndIf
  EndIf

EndEvent

Event OnDying(Actor Killer)

  Debug.TraceAndBox("Zombie Dying: " + Self.GetReference())
  RegisterForSingleUpdate(fOnDyingDelay)

EndEvent

Event OnDeath(Actor Killer)

  Debug.TraceAndBox("Zombie Died: " + Self.GetReference())
  RegisterForSingleUpdate(fWait)

EndEvent
