Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; IMPORTS
;
;-------------------------------------------------------------------------------

Import NEP_ReanimateFixLib

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateFixScript Property NEP_ReanimateFix Auto
{Reanimate Fix Quext script.}

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

  Bool Done = NEP_ReanimateFix.UntrackZombie(Self, Zombie)

  While !Done
    Utility.Wait(fWait)
    Done = NEP_ReanimateFix.UntrackZombie(Self, Zombie)
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

  RegisterForSingleUpdate(fOnDyingDelay)

EndEvent

Event OnDeath(Actor Killer)

  RegisterForSingleUpdate(fWait)

EndEvent
