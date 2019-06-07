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

Function UntrackZombie(Actor Zombie)

  Bool Done = Controller.UntrackZombie(Self, Zombie)

  If !Done
    RegisterForModEvent("RDF_AliasControllerReady", "AliasControllerReady")
  Else
    GoToState("")
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

State Dying

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

  Event AliasControllerReady(String EventName, String CallbackName)

    UnregisterForModEvent("RDF_AliasControllerReady")

    Actor Zombie = Self.GetReference() as Actor

    If Zombie
      UntrackZombie(Zombie)
    EndIf

  EndEvent

EndState

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
      GoToState("Dying")
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

Event AliasControllerReady(String EventName, String CallbackName)

  UnregisterForModEvent("RDF_AliasControllerReady")

EndEvent
